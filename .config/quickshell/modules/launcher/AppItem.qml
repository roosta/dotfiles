import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick
import qs
import qs.config
import qs.components
import qs.services

Item {
  id: root
  required property DesktopEntry modelData
  anchors.left: parent?.left
  anchors.right: parent?.right
  anchors.rightMargin: Appearance.spacing.p2 + Appearance.spacing.p1
  implicitHeight: Appearance.launcher.itemHeight
  MouseArea {
    id: mouse
    anchors.fill: parent
    hoverEnabled: true

    HoverHandler {
      id: hover
      cursorShape: Qt.PointingHandCursor
    }
    onClicked: {
      AppSearch.launch(root.modelData)
      GlobalState.closeLauncher()
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
        source: Quickshell.iconPath(root.modelData?.icon, Icons.icons.missing)
        Layout.margins: Appearance.spacing.p2
        implicitWidth: icon.height
        Layout.fillHeight: true
      }

      ColumnLayout {
        Layout.margins: Appearance.spacing.p2
        Layout.fillWidth: true
        Text {
          id: name
          text: root.modelData?.name ?? ""
          color: Appearance.srcery.brightWhite
          font {
            family: Appearance.font.main
            pixelSize: Appearance.font.size1
          }
        }
        Text {
          color: Appearance.srcery.white
          elide: Text.ElideRight
          text: (root.modelData?.comment || root.modelData?.genericName || root.modelData?.name) ?? ""
          Layout.fillWidth: true
          font {
            family: Appearance.font.light
            pixelSize: Appearance.font.size1
          }

        }
      } 
    }
  }
}

