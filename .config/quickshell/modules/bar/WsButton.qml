import QtQuick
import qs.services
import Quickshell
import qs.components
// import qs.services
import Quickshell.Hyprland
import QtQuick.Controls
import QtQuick.Layouts
import qs.config
pragma ComponentBehavior: Bound

Button {
  id: root
  property int direction: -1

  required property string monitorId

  readonly property HyprlandMonitor monitor: Hyprland
    .monitorFor(root.QsWindow.window?.screen)
  readonly property int activeWorkspaceId: monitor?.activeWorkspace?.id ?? 1
  property var workspaces: HyprlandData.workspacesByMonitor[monitorId] ?? []

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
  onPressed: {
    const move = activeWorkspaceId + root.direction
    if (move <= workspaces.length && move >= 1) {
      Hyprland.dispatch(`hl.dsp.window.move({ workspace = ${move}, window = "activewindow", follow = true })`)
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
