
import Quickshell
import QtQuick
// import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Wayland

import qs.utils
import qs.services

Item {
  id: root
  anchors.fill: parent
  required property string monitorId

  property var workspaces: HyprlandData.workspacesByMonitor[monitorId] ?? []

  readonly property var occupied: workspaces.reduce((acc, ws) => {
    acc[ws.id] = ws?.windows > 0;
    return acc;
  }, {})
  readonly property HyprlandMonitor monitor: Hyprland
  .monitorFor(root.QsWindow.window?.screen)
  readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
  readonly property int activeWorkspaceId: monitor?.activeWorkspace?.id ?? 1
  property var windows: HyprlandData.windowsByWorkspace[activeWorkspaceId] ?? []
  property bool onlyFloating: windows.every(w => w.floating) ?? false
  readonly property bool isOccupied: occupied[activeWorkspaceId] ?? false
  Image {
    visible: !root.isOccupied || root.onlyFloating
    anchors.fill: parent
    source: Paths.wallpaper
    fillMode: Image.PreserveAspectCrop
  }
}
