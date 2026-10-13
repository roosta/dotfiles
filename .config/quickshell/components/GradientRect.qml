// GradientRect.qml
import QtQuick
import QtQuick.Effects
import QtQuick.Shapes

// Rectangle that support a gradient border, while also allowing for transparent "content"
//
// Rendering layout (bottom to top):
//   1. content fill
//   2. solid ring drawn directly in borderColor
//   3. gradient ring (layered gradient masked by a ring), faded in/out with
//      gradientActive. Its layered content is static, so it never goes stale.
Item {
  id: root
  property alias gradient: gradientRect.gradient
  property color borderColor: "black"
  property color color: "transparent"   // content fill; "transparent" keeps see-through behavior
  property int borderWidth: 1
  property int radius: 0
  property real gradientAngle: 0
  property int gradientPadding: 10

  // Crossfade the gradient in/out over the solid borderColor ring
  property bool gradientActive: true
  property int gradientAnimationDuration: 300

  // Dashed border support
  property bool dashed: false
  // dashPattern is in units of strokeWidth (borderWidth): [dash, gap, ...]
  property var dashPattern: [4, 4]
  property real dashOffset: 0

  // Marching ants animation
  property bool animated: false
  // milliseconds for one full dash-pattern cycle
  property int animationDuration: 500

  readonly property bool useGradient: gradient !== null && gradient !== undefined

  function gradientSize() {
    const rad = root.gradientAngle * Math.PI / 180
    const absCos = Math.abs(Math.cos(rad))
    const absSin = Math.abs(Math.sin(rad))
    return {
      width:  width * absCos + height * absSin + gradientPadding,
      height: width * absSin + height * absCos + gradientPadding
    }
  }

  // Ring shape: solid ring (even-odd filled) or dashed outline, in ringColor
  component Ring: Shape {
    id: ring
    property color ringColor: "white"
    property bool dashed: false
    property int borderWidth: 1
    property int radius: 0
    property var dashPattern: [4, 4]
    property real dashOffset: 0
    preferredRendererType: Shape.CurveRenderer

    // Solid ring: outer filled minus inner (even-odd) -> alpha hole
    ShapePath {
      fillRule: ShapePath.OddEvenFill
      fillColor: ring.dashed ? "transparent" : ring.ringColor
      strokeWidth: 0

      PathRectangle {
        x: 0; y: 0
        width: ring.width
        height: ring.height
        radius: ring.radius
      }
      PathRectangle {
        x: ring.borderWidth
        y: ring.borderWidth
        width:  ring.width  - ring.borderWidth * 2
        height: ring.height - ring.borderWidth * 2
        radius: Math.max(0, ring.radius - ring.borderWidth)
      }
    }

    // Dashed ring: stroke the outline centered within the border width
    ShapePath {
      fillColor: "transparent"
      strokeColor: ring.dashed ? ring.ringColor : "transparent"
      strokeWidth: ring.borderWidth
      strokeStyle: ShapePath.DashLine
      dashPattern: ring.dashPattern
      dashOffset: ring.dashOffset
      capStyle: ShapePath.FlatCap

      PathRectangle {
        x: ring.borderWidth / 2
        y: ring.borderWidth / 2
        width:  ring.width  - ring.borderWidth
        height: ring.height - ring.borderWidth
        radius: Math.max(0, ring.radius - ring.borderWidth / 2)
      }
    }
  }

  // Content fill, sits inside the border ring. Skipped entirely when transparent.
  Rectangle {
    anchors {
      fill: parent
      margins: root.borderWidth
    }
    radius: Math.max(0, root.radius - root.borderWidth)
    color: root.color
    visible: root.color.a > 0
  }

  // Solid ring, drawn directly (no layer/effect)
  Ring {
    anchors.fill: parent
    ringColor: root.borderColor
    dashed: root.dashed
    borderWidth: root.borderWidth
    radius: root.radius
    dashPattern: root.dashPattern
    dashOffset: root.dashOffset
  }

  // Gradient source (static content, only used when a gradient is assigned)
  Item {
    id: gradientSource
    visible: false
    layer.enabled: root.useGradient
    anchors.fill: parent

    Rectangle {
      id: gradientRect
      rotation: root.gradientAngle
      anchors.centerIn: parent
      width:  root.gradientSize().width
      height: root.gradientSize().height
    }
  }

  // Ring-shaped alpha mask for the gradient
  Ring {
    id: ringMask
    visible: false
    layer.enabled: root.useGradient
    anchors.fill: parent
    ringColor: "white"
    dashed: root.dashed
    borderWidth: root.borderWidth
    radius: root.radius
    dashPattern: root.dashPattern
    dashOffset: root.dashOffset
  }

  // Marching ants: continuously shift the dash offset by one pattern length
  NumberAnimation {
    target: root
    property: "dashOffset"
    running: root.dashed && root.animated
    from: 0
    to: root.dashPattern.reduce((a, b) => a + b, 0)
    duration: root.animationDuration
    loops: Animation.Infinite
  }

  // Gradient ring on top of the solid ring, crossfaded via gradientActive
  MultiEffect {
    anchors.fill: parent
    visible: root.useGradient && opacity > 0
    opacity: root.gradientActive ? 1 : 0
    source: gradientSource
    maskEnabled: true
    maskSource: ringMask
    maskThresholdMin: 0.5

    Behavior on opacity {
      NumberAnimation {
        duration: root.gradientAnimationDuration
        easing.type: Easing.OutCubic
      }
    }
  }
}

