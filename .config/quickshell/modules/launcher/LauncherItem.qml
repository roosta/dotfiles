import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick
import qs
import qs.utils
import qs.config
// import qs.components
// import qs.services

Item {
  id: root
  required property string name
  required property string description
  anchors.top: parent?.top
  anchors.bottom: parent?.bottom
  // anchors.rightMargin: Appearance.spacing.p2 + Appearance.spacing.p1
  implicitWidth: height
  signal clicked()
  property alias iconSource: icon.source
  property int iconSize: 64
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
    border.color: mouse.containsMouse ? Appearance.srcery.gray6 : Appearance.srcery.gray3
    color: "transparent"
    border.width: Appearance.bar.borderWidth
    // border.color: Appearance.srcery.gray3


    Behavior on color {
      ColorAnimation {
        duration: 150
        easing.type: Easing.OutQuad
      }
    }
    ColumnLayout {

      anchors.margins: Appearance.spacing.p2
      anchors.fill: parent
      spacing: 0
      ColumnLayout {
        // Layout.margins: Appearance.spacing.p2
        Layout.fillWidth: true
        Text {
          id: name
          text: root.name
          color: Appearance.srcery.brightWhite
          font {
            family: Appearance.font.main
            pointSize: Appearance.font.large
          }
        }
        Text {
          color: Appearance.srcery.white
          elide: Text.ElideRight
          text: root.description
          Layout.fillWidth: true
          wrapMode: Text.Wrap
          font {
            family: Appearance.font.light
            pointSize: Appearance.font.small
          }

        }
      }

      Item {
        Layout.fillHeight: true
      }

      Rectangle {
        implicitWidth: root.iconSize
        radius: 4
        color: Functions.transparentize(Appearance.srcery.black, 0.7)
        implicitHeight: root.iconSize
        border.color: Appearance.srcery.gray3
        IconImage {
          id: icon
          anchors.fill: parent
          anchors.margins: Appearance.spacing.p2
        }
      }

    }
  }
}

