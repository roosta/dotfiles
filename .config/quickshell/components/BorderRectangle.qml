import QtQuick

Item {
  id: root
  property alias color: innerRect.color

  property alias borderColor : borderRect.color
  property int borderWidth: 0

  property int leftBorder : borderWidth
  property int rightBorder : borderWidth
  property int topBorder : borderWidth
  property int bottomBorder : borderWidth

  property int radius: 0
  Rectangle
  {
    id: borderRect
    anchors.fill: parent
    radius: root.radius

    Rectangle
    {
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
