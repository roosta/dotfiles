import qs.services
import qs.config
import qs.utils
import QtQuick
// import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets

Item {
  id: root
  readonly property HyprlandMonitor monitor: Hyprland.monitorFor(root.QsWindow.window?.screen)
  readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
  property string activeWindowAddress: `0x${activeWindow?.HyprlandToplevel?.address}`
  property bool focusingThisMonitor: HyprlandData.activeWorkspace?.monitor == monitor?.name

  property int iconSize: 26 * Config.scale

  Layout.fillWidth: true
  Layout.fillHeight: true
  RowLayout {
    id: rowLayout
    anchors.fill: parent
    BorderRectangle {
      implicitWidth: Appearance.bar.height
      implicitHeight: Appearance.bar.height
      Layout.topMargin: Appearance.bar.borderWidth
      color: Appearance.srcery.black
      rightBorder: Appearance.bar.borderWidth
      borderColor: Appearance.srcery.gray3
      IconImage {
        id: windowIcon
        anchors.centerIn: parent
        source: {
          if (root.activeWindow?.activated) {
            Icons.getWindowIcon(root.activeWindow?.appId)
          } else {
            return Icons.getIcon("workspace")
          }
        }
        implicitSize: root.iconSize
      }
    }
    ColumnLayout {
      id: colLayout
      Layout.fillWidth: true
      spacing: -2
      Text {

        font {
          family: Appearance.font.light
          pixelSize: Appearance.font.size1
        }

        color: Appearance.srcery.brightBlack
        text: {
          if (root.activeWindow?.activated) {
            return Functions.capitalize(root.activeWindow?.appId)
          } else {
            return "Desktop"
          }
        }
      }
      Text {
        id: window
        elide: Text.ElideRight
        Layout.fillWidth: true
        Layout.rightMargin: Appearance.spacing.p5
        font {
          family: Appearance.font.light
          pixelSize: Appearance.font.size1
        }

        color: Appearance.srcery.white
        text: {
          if (root.activeWindow?.activated) {
            return root.activeWindow?.title
          }
          return `Workspace ${HyprlandData.activeWorkspace?.id}`
        }
      }
    }
  }
}
