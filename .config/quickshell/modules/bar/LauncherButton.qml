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

  // color: Appearance.srcery.brightWhite
  required property string monitorId
  Layout.topMargin: Appearance.bar.borderWidth
  implicitWidth: Appearance.bar.height - Appearance.spacing.p3
  implicitHeight: Appearance.bar.height - Appearance.bar.borderWidth
    - Appearance.spacing.p1 * 2

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
    color: Appearance.srcery.black
    borderColor: Appearance.srcery.gray3
    borderWidth: Appearance.bar.borderWidth
    BorderRect {
      id: innerRect
      anchors.centerIn: parent
      implicitWidth: parent.width * 0.5
      implicitHeight: parent.height * 0.5
      borderWidth: Appearance.bar.borderWidth
      color: Appearance.srcery.black
      rotation: 45
      borderColor: Appearance.srcery.gray3
    }
  }

  states: [

    State {
      name: "active"
      when: root.active && !hover.hovered
      PropertyChanges { innerRect.rotation: 0 }
      PropertyChanges { outerRect.borderColor: Appearance.srcery.brightBlack }
      PropertyChanges { innerRect.borderColor: Appearance.srcery.brightWhite }
    },

    State {
      name: "hovered"
      when: hover.hovered && !root.active
      PropertyChanges { outerRect.borderColor: Appearance.srcery.gray6 }
      PropertyChanges { innerRect.borderColor: Appearance.srcery.brightWhite }
    },

    State {
      name: "activeHovered"
      when: hover.hovered && root.active
      PropertyChanges { outerRect.borderColor: Appearance.srcery.brightWhite }
      PropertyChanges { innerRect.borderColor: Appearance.srcery.brightWhite }
      PropertyChanges { innerRect.rotation: 0 }
    }
  ]

  transitions: [
    Transition {
      NumberAnimation {
        properties: "rotation"
        duration: Appearance.durations.normal
        easing.type: Easing.OutCubic
      }
      ColorAnimation {
        duration: Appearance.durations.small
        easing.type: Easing.OutQuad
      }
    }
  ]
}
