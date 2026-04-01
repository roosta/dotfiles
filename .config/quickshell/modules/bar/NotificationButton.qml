// ┌────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█▀█░█▀█░▀█▀░▀█▀░█▀▀░█░█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█░█░█░█░░█░░░█░░█▀▀░░█░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀░▀░▀▀▀░░▀░░▀▀▀░▀░░░░▀░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>       ├┤
// ││ Repo    : https://github.com/roosta/dotfiles ││
// ││ Site    : https://www.roosta.sh              ││
// ├┤ License : GNU General Public License v3      ├┤
// ┆└──────────────────────────────────────────────┘┆

// import QtQuick.Controls
import qs.components
import qs.config
import qs.services
import qs
// import qs.utils
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes
// import Quickshell
// import Quickshell.Hyprland
// import Quickshell.Wayland
// import Quickshell.Widgets

Button {
  id: root
  Layout.topMargin: Appearance.bar.borderWidth
  implicitWidth: Appearance.bar.height - Appearance.spacing.p3
  implicitHeight: Appearance.bar.height - Appearance.bar.borderWidth - Appearance.spacing.p1 * 2

  property bool active: Notifications?.list.length > 0 ?? false
  property bool menuOpen: GlobalState.launcherOpen
    && GlobalState.launcherMode === "notifications"
  required property string monitorId

  HoverHandler {
    id: hover
    cursorShape: Qt.PointingHandCursor
  }

  onPressed: {
    GlobalState.toggleLauncher({id: root.monitorId, mode: "notifications"})
  }
  states: [
    State {
      name: "open"
      when: root.menuOpen && !root.hovered && !root.active
      PropertyChanges { shape.rotation: 90 }
      PropertyChanges { path.strokeColor: Appearance.srcery.brightWhite }
      PropertyChanges { rect.borderColor: Appearance.srcery.brightBlack }

    },
    State {
      name: "openActive"
      when: root.menuOpen && !root.hovered && root.active
      PropertyChanges { shape.rotation: 90 }
      PropertyChanges { path.strokeColor: Appearance.srcery.brightWhite }
      PropertyChanges { rect.borderColor: Appearance.srcery.brightBlack }
    },
    State {
      name: "openActiveHovered"
      when: root.menuOpen && root.hovered && root.active
      PropertyChanges { shape.rotation: 90 }
      PropertyChanges { path.strokeColor: Appearance.srcery.brightWhite }
      PropertyChanges { rect.borderColor: Appearance.srcery.brightWhite }
    },
    State {
      name: "openHovered"
      when: root.menuOpen && root.hovered && !root.active
      PropertyChanges { shape.rotation: 90 }
      PropertyChanges { path.strokeColor: Appearance.srcery.brightWhite }
      PropertyChanges { rect.borderColor: Appearance.srcery.brightWhite }
    },
    State {
      name: "active"
      when: root.active && !root.hovered && !root.menuOpen
      PropertyChanges { shape.rotation: 180 }
      PropertyChanges { path.strokeColor: Appearance.srcery.white }
      PropertyChanges { rect.borderColor: Appearance.srcery.gray5 }
    },
    State {
      name: "activeHovered"
      when: root.active && root.hovered && !root.menuOpen
      PropertyChanges { shape.rotation: 180 }
      PropertyChanges { path.strokeColor: Appearance.srcery.brightWhite }
      PropertyChanges { rect.borderColor: Appearance.srcery.brightBlack }
    },
    State {
      name: "hovered"
      when: hover.hovered && !root.active && !root.menuOpen
      PropertyChanges { rect.borderColor: Appearance.srcery.gray6 }
      PropertyChanges { path.strokeColor: Appearance.srcery.brightWhite }

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
  background: BorderRect {
    id: rect
    color: Appearance.srcery.black
    borderColor: Appearance.srcery.gray3
    borderWidth: Appearance.bar.borderWidth
    anchors.fill: parent

    Shape {
      id: shape
      anchors.centerIn: parent
      width: Appearance.bar.iconSize
      height: Appearance.bar.iconSize
      ShapePath {
        strokeWidth: 1
        id: path
        strokeColor: Appearance.srcery.gray3
        fillColor: Appearance.srcery.black
        PathSvg {
          id: svg
          path: "M 10 1.7 L 18.3 16.3 L 1.7 16.3 Z"
        }
      }
    }
  }
}
