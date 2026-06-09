// ┌────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█░░░█▀█░█░█░█▀█░█▀▀░█░█░█▀▀░█▀▄░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█░░░█▀█░█░█░█░█░█░░░█▀█░█▀▀░█▀▄░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>               ├┤
// ││ Repo    : https://github.com/roosta/dotfiles         ││
// ││ Site    : https://www.roosta.sh                      ││
// ├┤ License : GNU General Public License v3              ├┤
// ┆└──────────────────────────────────────────────────────┘┆

// import qs.services
import qs.config
// import qs.utils
import qs.components
import qs
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
// import Quickshell
// import Quickshell.Hyprland
// import Quickshell.Wayland
// import Quickshell.Widgets

Button {
  id: root

  // color: Style.srcery.brightWhite
  required property string monitorId
  Layout.topMargin: Style.bar.borderWidth
  implicitWidth: Style.bar.height - Style.spacing.p3
  implicitHeight: Style.bar.height - Style.bar.borderWidth
    - Style.spacing.p1 * 2

  property bool active: GlobalState.launcherOpen
    && GlobalState.launcherMonitorId === root.monitorId
    && GlobalState.launcherMode !== "notifications"

  onPressed: {
    GlobalState.toggleLauncher({id: root.monitorId })
  }

  HoverHandler {
    id: hover
    cursorShape: Qt.PointingHandCursor
  }

  background: BorderRect {
    id: outerRect
    color: Style.srcery.black
    borderColor: Style.srcery.gray3
    borderWidth: Style.bar.borderWidth
    BorderRect {
      id: innerRect
      anchors.centerIn: parent
      implicitWidth: parent.width * 0.5
      implicitHeight: parent.height * 0.5
      borderWidth: Style.bar.borderWidth
      color: Style.srcery.black
      rotation: 45
      borderColor: Style.srcery.gray3
    }
  }

  states: [

    State {
      name: "active"
      when: root.active && !hover.hovered
      PropertyChanges { innerRect.rotation: 0 }
      PropertyChanges { outerRect.borderColor: Style.srcery.brightBlack }
      PropertyChanges { innerRect.borderColor: Style.srcery.brightWhite }
    },

    State {
      name: "hovered"
      when: hover.hovered && !root.active
      PropertyChanges { outerRect.borderColor: Style.srcery.gray6 }
      PropertyChanges { innerRect.borderColor: Style.srcery.brightWhite }
    },

    State {
      name: "activeHovered"
      when: hover.hovered && root.active
      PropertyChanges { outerRect.borderColor: Style.srcery.brightWhite }
      PropertyChanges { innerRect.borderColor: Style.srcery.brightWhite }
      PropertyChanges { innerRect.rotation: 0 }
    }
  ]

  transitions: [
    Transition {
      NumberAnimation {
        properties: "rotation"
        duration: Style.durations.normal
        easing.type: Easing.OutCubic
      }
      ColorAnimation {
        duration: Style.durations.small
        easing.type: Easing.OutQuad
      }
    }
  ]
}
