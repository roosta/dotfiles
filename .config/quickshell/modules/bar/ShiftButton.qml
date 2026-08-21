import QtQuick
import Quickshell.Wayland
import qs.services
import Quickshell
import qs.components
// import qs.services
import Quickshell.Hyprland
import QtQuick.Controls
import QtQuick.Layouts
import qs.config
import Quickshell.Io
pragma ComponentBehavior: Bound

Button {
  id: root
  property int direction: -1

  required property string monitorId

  readonly property HyprlandMonitor monitor: Hyprland
    .monitorFor(root.QsWindow.window?.screen)
  readonly property int activeWorkspaceId: monitor?.activeWorkspace?.id ?? 1
  property var workspaces: HyprlandData.workspacesByMonitor[monitorId] ?? []
  property var persistent: workspaces.filter(w => w.ispersistent)

  HoverHandler {
    id: hover
    cursorShape: Qt.PointingHandCursor
  }
  states: [
    State {
      name: "pressed"
      when: root.pressed

      PropertyChanges {
        triangle.strokeColor: Style.srcery.brightWhite
      }
    },
    State {
      name: "hovered"
      when: hover.hovered
      PropertyChanges {
        triangle.strokeColor: Style.srcery.brightBlack
      }
    }
  ]


  // Custom move window dispatcher, I need to disable mouse warp while doing
  // workspace moves via this button, otherwise the mouse cursor snaps to middle
  // of active window on every button press, but I want it enabled otherwise
  Process {
    id: moveWindow
    running: false
    property int wsid: 0
    command: ["hyprctl", "eval", `hl.config({cursor = { no_warps = true }}); hl.dispatch(hl.dsp.window.move({ workspace = ${wsid}, window = 'activewindow', follow = true })); hl.config({cursor = { no_warps = false }})
    `]
  }

  onPressed: {
    let move = activeWorkspaceId + root.direction
    let focusedMonitor = Hyprland.focusedMonitor?.name ?? ""
    if (focusedMonitor !== Config.displays.center && focusedMonitor !== Config.displays.tv) { return }

    if (move > persistent.length) {
      if (direction < 0) {
        move = persistent.length
      } else { return }
    }
    if (move > 0) {
      moveWindow.wsid = move
      moveWindow.running = true
    }
  }

  transitions: [
    Transition {
      ColorAnimation {
        duration: Style.durations.tiny
        easing.type: Easing.InOutQuad
      }
    }
  ]

  Layout.preferredHeight: Style.bar.height - Style.bar.borderWidth - Style.spacing.p1 * 2
  Layout.preferredWidth: 23
  background: Rectangle {
    anchors.fill: parent
    color: "transparent"
    Triangle {
      id: triangle
      height: 20

      anchors.right: root.direction > 0 ? parent.right : undefined
      // anchors.fill: parent
      width: Style.bar.height - Style.bar.borderWidth - Style.spacing.p1 * 2
      rotation: root.direction > 0 ? 90 : 270
      anchors.verticalCenter: parent.verticalCenter
    }
  }
}
