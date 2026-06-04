// GradientRect.qml
import QtQuick
import QtQuick.Effects
import QtQuick.Shapes

// Rectangle that support a gradient border, while also allowing for transparent "content"
Item {
  id: root
  property alias gradient: gradientRect.gradient
  property color borderColor: "black"
  property int borderWidth: 1
  property int radius: 0
  property real gradientAngle: 0

  function gradientSize() {
    const rad = root.gradientAngle * Math.PI / 180
    const absCos = Math.abs(Math.cos(rad))
    const absSin = Math.abs(Math.sin(rad))
    return {
      width:  width * absCos + height * absSin,
      height: width * absSin + height * absCos
    }
  }

  // The gradient source
  Rectangle {
    id: gradientRect
    visible: false
    layer.enabled: true
    color: root.borderColor
    rotation: root.gradientAngle
    anchors.centerIn: parent
    implicitWidth: root.gradientSize().width
    implicitHeight: root.gradientSize().height
  }

  // Ring-shaped alpha mask via even-odd fill rule:
  // outer rounded rect filled, inner rounded rect subtracts -> true alpha hole
  Shape {
    id: ringMask
    visible: false
    layer.enabled: true
    anchors.fill: parent
    preferredRendererType: Shape.CurveRenderer

    ShapePath {
      fillRule: ShapePath.OddEvenFill
      fillColor: "white"
      strokeWidth: 0

      // Outer rounded rect
      PathRectangle {
        x: 0; y: 0
        width: root.width
        height: root.height
        radius: root.radius
      }
      // Inner rounded rect (the hole)
      PathRectangle {
        x: root.borderWidth
        y: root.borderWidth
        width:  root.width  - root.borderWidth * 2
        height: root.height - root.borderWidth * 2
        radius: Math.max(0, root.radius - root.borderWidth)
      }
    }
  }

  MultiEffect {
    anchors.fill: parent
    source: gradientRect
    maskEnabled: true
    maskSource: ringMask
    maskThresholdMin: 0.5   // crisp edge
  }
}
