import QtQuick
import Quickshell.Widgets
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick.Layouts
import qs.services 
import qs.config
pragma ComponentBehavior: Bound

Rectangle {
  id: root
  color: Appearance.srcery.gray2
  required property int show
  required property ShellScreen screen
  readonly property var occupied: HyprlandData.workspaces.reduce((acc, curr) => {
    acc[curr.id] = curr?.windows > 0;
    return acc;
  }, {})
  readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
  readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

  // readonly property bool onSpecial: Hyprland.monitorFor(screen)?.lastIpcObject.specialWorkspace.name !== ""
  readonly property int activeWsId: monitor?.activeWorkspace?.id ?? 1
  readonly property int groupOffset: Math.floor((activeWsId - 1) / show) * show

  implicitWidth: layout.implicitWidth + Appearance.spacing.p2
  Layout.fillHeight: true
  radius: Appearance.bar.radius
  Item {
    id: inner
    anchors.fill: parent
    // Rectangle {
    //   z: 2
    //   radius: Appearance.bar.radius
    // }
    RowLayout {
      id: layout
      spacing: Appearance.spacing.p2
      anchors.centerIn: parent
      Repeater {
        model: root.show

        Workspace {
          occupied: root.occupied
          groupOffset: root.groupOffset
          activeWsId: root.activeWsId
        }
      }
    }
    // MouseArea {
    //   anchors.fill: parent
    //   onPressed: event => {
    //     const ws = layout.childAt(event.x, event.y).index + root.groupOffset + 1;
    //     if (Hyprland.activeWsId !== ws) {
    //       Hyprland.dispatch(`workspace ${ws}`);
    //     }
    //   }
    // }
  }
}
