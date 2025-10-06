import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick
import qs
import qs.config
import qs.components

Item {
  id: root
  required property DesktopEntry modelData
  anchors.left: parent?.left
  anchors.right: parent?.right
  anchors.rightMargin: Appearance.spacing.p2 + Appearance.spacing.p0
  implicitHeight: Appearance.launcher.itemHeight
  BorderRectangle {
    anchors.fill: parent
    color: Appearance.srcery.black
    borderWidth: Appearance.bar.borderWidth
    borderColor: Appearance.srcery.gray3
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

