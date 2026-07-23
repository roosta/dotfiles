// GradientRect.qml
import QtQuick
import QtQuick.Effects
import QtQuick.Shapes

// Rectangle that support a gradient border, while also allowing for transparent "content"
Item {
  id: root
  property alias gradient: gradientRect.gradient
  property color borderColor: "black"
  property color color: "transparent"   // content fill; "transparent" keeps see-through behavior
  property int borderWidth: 1
  property int radius: 0
  property real gradientAngle: 0
  property int gradientPadding: 10

  // Crossfade the gradient in/out over the solid borderColor fill
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

  function gradientSize() {
    const rad = root.gradientAngle * Math.PI / 180
    const absCos = Math.abs(Math.cos(rad))
    const absSin = Math.abs(Math.sin(rad))
    return {
      width:  width * absCos + height * absSin + gradientPadding,
      height: width * absSin + height * absCos + gradientPadding
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

  // The gradient source
  Item {
    id: gradientSource
    visible: false
    layer.enabled: true
    anchors.fill: parent

    // Solid fallback beneath the gradient so we can crossfade to/from it
    Rectangle {
      rotation: root.gradientAngle
      anchors.centerIn: parent
      width:  gradientRect.width
      height: gradientRect.height
      color: root.borderColor
    }

    Rectangle {
      id: gradientRect
      rotation: root.gradientAngle
      anchors.centerIn: parent
      width:  root.gradientSize(root.gradientAngle).width
      height: root.gradientSize(root.gradientAngle).height
      color: root.borderColor  // solid fallback; gradient overrides this when set
      opacity: root.gradientActive ? 1 : 0
      Behavior on opacity {
        NumberAnimation {
          duration: root.gradientAnimationDuration
          easing.type: Easing.OutCubic
        }
      }
    }
  }

  // Ring-shaped alpha mask via even-odd fill rule:
  // outer rounded rect filled, inner rounded rect subtracts -> true alpha hole
  Shape {
    id: ringMask
    visible: false
    layer.enabled: true
    anchors.fill: parent
    preferredRendererType: Shape.CurveRenderer

    // Solid ring: outer filled minus inner (even-odd) -> alpha hole
    ShapePath {
      fillRule: ShapePath.OddEvenFill
      fillColor: root.dashed ? "transparent" : "white"
      strokeWidth: 0

      PathRectangle {
        x: 0; y: 0
        width: root.width
        height: root.height
        radius: root.radius
      }
      PathRectangle {
        x: root.borderWidth
        y: root.borderWidth
        width:  root.width  - root.borderWidth * 2
        height: root.height - root.borderWidth * 2
        radius: Math.max(0, root.radius - root.borderWidth)
      }
    }

    // Dashed ring: stroke the outline centered within the border width
    ShapePath {
      fillColor: "transparent"
      strokeColor: root.dashed ? "white" : "transparent"
      strokeWidth: root.borderWidth
      strokeStyle: ShapePath.DashLine
      dashPattern: root.dashPattern
      dashOffset: root.dashOffset
      capStyle: ShapePath.FlatCap

      PathRectangle {
        x: root.borderWidth / 2
        y: root.borderWidth / 2
        width:  root.width  - root.borderWidth
        height: root.height - root.borderWidth
        radius: Math.max(0, root.radius - root.borderWidth / 2)
      }
    }
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

  MultiEffect {
    anchors.fill: parent
    source: gradientSource
    maskEnabled: true
    maskSource: ringMask
    maskThresholdMin: 0.5
  }
}
