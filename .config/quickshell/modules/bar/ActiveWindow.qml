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

  property int iconSize: 26

  implicitWidth: rowLayout.implicitWidth
  RowLayout {
    id: rowLayout
    // anchors.centerIn: parent
    BorderRectangle {
      implicitWidth: Appearance.bar.height
      implicitHeight: Appearance.bar.height
      Layout.topMargin: 1
      color: Appearance.srcery.black
      rightBorder: 1
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
      spacing: -2
      Text {

        elide: Text.ElideRight
        Layout.fillWidth: true
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
        Layout.fillWidth: true
        font {
          family: Appearance.font.main
          pixelSize: Appearance.font.size1
        }

        color: Appearance.srcery.white
        text: {
          if (root.activeWindow?.activated) {
            return Functions.truncate(root.activeWindow?.title)
          }
          return `Workspace ${HyprlandData.activeWorkspace?.id}`
        }
      }
    }
  }
  
}
