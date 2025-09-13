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

  property int iconSize: 20

  function capitalize(val) {
    return String(val).charAt(0).toUpperCase() + String(val).slice(1);
  }
  function log(val) {
    console.log(JSON.stringify(val, null, 2)) 
    return val
  }
  property var logme: log(HyprlandData.windowList)
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

  implicitWidth: rowLayout.implicitWidth
  RowLayout {
    id: rowLayout
    anchors.centerIn: parent
    Rectangle {
      Layout.fillHeight: true
      implicitWidth: root.iconSize + Appearance.spacing.p1
      implicitHeight: root.iconSize + Appearance.spacing.p1
      radius: 2
      color: Appearance.srcery.gray3
      IconImage {
        id: windowIcon
        anchors.centerIn: parent
        source: Icons.getWindowIcon(root.activeWindow?.appId)
        implicitSize: root.iconSize
      }
    }
    ColumnLayout {
      id: colLayout
      spacing: -4
      Text {

        elide: Text.ElideRight
        Layout.fillWidth: true
        font {
          family: Appearance.font.main
          pixelSize: Appearance.font.size1
        }

        color: Appearance.srcery.brightBlack
        text: {
          if (root.activeWindow?.activated) {
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
          pixelSize: Appearance.font.size1
        }

        color: Appearance.srcery.white
        text: {
          if (root.activeWindow?.activated) {
            return root.truncate(root.activeWindow?.title)
          }
          return `Workspace ${HyprlandData.activeWorkspace?.id}`
        }
      }
    }
  }
  
}
