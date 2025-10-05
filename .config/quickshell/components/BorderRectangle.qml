import QtQuick

// Rectangle that supports separate borders and support for angled gradient borders
// Originally based on this: https://stackoverflow.com/a/59324531/4306379
Item {
  id: root
  property alias color: innerRect.color

  property alias gradient: colorRect.gradient
  property int borderWidth: 0
  property alias borderColor : colorRect.color

  property int leftBorder : borderWidth
  property int rightBorder : borderWidth
  property int topBorder : borderWidth
  property int bottomBorder : borderWidth
  property int radius: 0
  property alias gradientAngle: colorRect.rotation

  clip: true

  // Calculate the size needed for a rotated (gradient) rectangle to fit inside content rectangle
  function gradientSize() {
    const rad = gradientAngle * Math.PI / 180
    const absCos = Math.abs(Math.cos(rad));
    const absSin = Math.abs(Math.sin(rad));
    const width = borderRect.width * absCos + borderRect.height * absSin;
    const height = borderRect.width * absSin + borderRect.height * absCos;

    return { width, height };
  }
  Rectangle {
    id: borderRect
    color: "transparent"
    anchors.fill: parent
    radius: root.radius

    Rectangle {
      id: colorRect
      implicitWidth: root.gradientSize().width
      implicitHeight: root.gradientSize().height
      anchors.centerIn: parent
    }

    Rectangle {
      id: innerRect

      anchors {
        fill: parent

        leftMargin: root.leftBorder
        rightMargin: root.rightBorder
        topMargin: root.topBorder
        bottomMargin: root.bottomBorder
      }
    }
  }
}
