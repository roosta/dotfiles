import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick
import qs
import qs.config
// import qs.components
// import qs.services

Item {
  id: root
  required property string name
  required property string description
  anchors.left: parent?.left
  anchors.right: parent?.right
  anchors.rightMargin: Appearance.spacing.p2 + Appearance.spacing.p1
  implicitHeight: Appearance.launcher.itemHeight
  signal clicked()
  property alias iconSource: icon.source
  MouseArea {
    id: mouse
    anchors.fill: parent
    hoverEnabled: true

    HoverHandler {
      id: hover
      cursorShape: Qt.PointingHandCursor
    }
    onClicked: {
      root.clicked()
    }
  }
  Rectangle {
    anchors.fill: parent
    color: mouse.containsMouse ? Appearance.srcery.gray1 : Appearance.srcery.black
    

    Behavior on color {
      ColorAnimation {
        duration: 150
        easing.type: Easing.OutQuad
      }
    }
    // border.width: 1
    // border.color: Appearance.srcery.white
    RowLayout {
      anchors.fill: parent
      Layout.margins: Appearance.spacing.p2
      spacing: 0
      IconImage {
        id: icon
        Layout.margins: Appearance.spacing.p2
        implicitWidth: icon.height
        Layout.fillHeight: true
      }

      ColumnLayout {
        Layout.margins: Appearance.spacing.p2
        Layout.fillWidth: true
        Text {
          id: name
          text: root.name
          color: Appearance.srcery.brightWhite
          font {
            family: Appearance.font.main
            pointSize: Appearance.font.normal
          }
        }
        Text {
          color: Appearance.srcery.white
          elide: Text.ElideRight
          text: root.description
          Layout.fillWidth: true
          font {
            family: Appearance.font.light
            pointSize: Appearance.font.small
          }

        }
      } 
    }
  }
}

