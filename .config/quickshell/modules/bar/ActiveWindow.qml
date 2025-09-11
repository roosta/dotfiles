import qs.services
import qs.config
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

  property int iconSize: 18

  implicitWidth: colLayout.implicitWidth
  // Item {
  //   id: windowIcon
  //   Layout.preferredWidth: root.iconSize
  //   Layout.preferredHeight: root.iconSize
  //   IconImage {
  //     source: Icons.getWindowIcon(root.activeWindow?.appId)
  //     anchors.centerIn: parent
  //     implicitSize: root.iconSize
  //   }
  // }
  ColumnLayout {
    id: colLayout
    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    anchors.right: parent.right
    spacing: -3
    Text {

      Layout.fillWidth: true
      font {
        family: Appearance.font.main
        pixelSize: Appearance.font.size1
      }

      elide: Text.ElideRight
      color: Appearance.srcery.brightBlack
      text: {
        if (root.focusingThisMonitorChanged && root.activeWindow?.activated) {
          return root.activeWindow?.appId
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
        pixelSize: Appearance.font.size2
      }

      function truncate(text) {
        if (typeof text !== "string") {
          console.warn("Not a string!") 
          return
        } 
        if (text && text.length >= Appearance.bar.textLength) {
          return `${text.substring(0, Appearance.bar.textLength)} ...`
        } 
        return text
      }

      elide: Text.ElideRight
      color: Appearance.srcery.white
      text: {
        if (root.focusingThisMonitor && root.activeWindow?.activated) {
          return truncate(root.activeWindow?.title)
        }
        return "Workspace"
      }
    }
  }
}
