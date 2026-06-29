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
// import QtQuick.Shapes
// import Quickshell
// import Quickshell.Hyprland
// import Quickshell.Wayland
// import Quickshell.Widgets

Button {
  id: root
  Layout.topMargin: Style.bar.borderWidth
  implicitWidth: implicitHeight
  implicitHeight: Style.bar.height - Style.bar.borderWidth - Style.spacing.p1 * 2

  Layout.rightMargin: Style.spacing.p1
  property bool active: Notifications?.list.length > 0 ?? false
  property bool menuOpen: GlobalState.launcherOpen
    && GlobalState.launcherMode === "notifications"
  required property string monitorId

  MouseArea {
    id: mouseArea
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor
    // anchors.fill: parent
    hoverEnabled: true
    x: -Style.spacing.p2
    y: -Style.spacing.p2 + Style.bar.borderWidth
    implicitWidth: parent.width + (Style.spacing.p2 * 2)
    implicitHeight: parent.height + (Style.spacing.p2 * 2)

    onClicked: (mouse) => {
      if (mouse.button === Qt.RightButton) {
        // GlobalState.toggleLauncher({id: root.monitorId })
      } else if (mouse.button === Qt.LeftButton) {
        GlobalState.toggleLauncher({
          id: root.monitorId, mode: "notifications",
          direction: Qt.RightToLeft,
        })
      }
    }
  }
  states: [
    State {
      name: "open"
      when: root.menuOpen && !mouseArea.containsMouse && !root.active
      PropertyChanges {
        rect.borderColor: Style.srcery.brightBlack
      }

    },
    State {
      name: "openActive"
      when: root.menuOpen && !mouseArea.containsMouse && root.active
      PropertyChanges {
        quad.bottomLeft:  Qt.point(0.5, 1)
        quad.bottomRight: Qt.point(0.5, 1)
        quad.topLeft:     Qt.point(0, 0)
        quad.topRight:    Qt.point(1, 0)
        quad.gradientEnabled: true
        dot.y: 5
      }
      PropertyChanges { rect.borderColor: Style.srcery.brightBlack }
    },
    State {
      name: "openActiveHovered"
      when: root.menuOpen && mouseArea.containsMouse && root.active
      PropertyChanges {
        // quad.rotation: 180
        quad.gradientEnabled: true

        quad.bottomLeft:  Qt.point(0.5, 1)
        quad.bottomRight: Qt.point(0.5, 1)
        quad.topLeft:     Qt.point(0, 0)
        quad.topRight:    Qt.point(1, 0)
        dot.y: 5
      }
      PropertyChanges { rect.borderColor: Style.srcery.brightWhite }
    },
    State {
      name: "openHovered"
      when: root.menuOpen && mouseArea.containsMouse && !root.active
      PropertyChanges {
        rect.borderColor: Style.srcery.brightWhite
      }
    },
    State {
      name: "active"
      when: root.active && !mouseArea.containsMouse && !root.menuOpen
      PropertyChanges {
        // quad.rotation: 180
        // quad.gradientEnabled: true
      }
      PropertyChanges {
        rect.borderColor: Style.srcery.gray5
        quad.bottomLeft:  Qt.point(0.5, 1)
        quad.bottomRight: Qt.point(0.5, 1)
        quad.topLeft:     Qt.point(0, 0)
        quad.topRight:    Qt.point(1, 0)
        dot.y: 5
      }
    },
    State {
      name: "activeHovered"
      when: root.active && mouseArea.containsMouse && !root.menuOpen
      PropertyChanges {
        quad.gradientEnabled: true
        quad.bottomLeft:  Qt.point(0.5, 1)
        quad.bottomRight: Qt.point(0.5, 1)
        quad.topLeft:     Qt.point(0, 0)
        quad.topRight:    Qt.point(1, 0)
        dot.y: 5
      }
      PropertyChanges { rect.borderColor: Style.srcery.brightBlack }
    },
    State {
      name: "hovered"
      when: mouseArea.containsMouse && !root.active && !root.menuOpen
      PropertyChanges { rect.borderColor: Style.srcery.gray6 }

    }
  ]

  transitions: [
    Transition {
      NumberAnimation {
        properties: "y"
        duration: Style.durations.normal
        easing.type: Easing.OutCubic
      }
      ColorAnimation {
        duration: Style.durations.small
        easing.type: Easing.OutQuad
      }
    }
  ]
  background: GradientRect {
    id: rect
    color: Style.srcery.black
    borderColor: Style.srcery.gray3
    borderWidth: Style.bar.borderWidth
    anchors.fill: parent

    Quad {
      id: quad
      width: 20
      height: 18
      topLeft:  Qt.point(0.5, 0)
      topRight: Qt.point(0.5, 0)
      anchors.centerIn: parent
      gradientEnabled: true
      strokeColor: Style.srcery.brightBlack
      gradientStart: Style.srcery.yellow
      gradientEnd: Style.srcery.cyan
      gradientRotation: 90
      // quad.gradientEnabled: true
      Behavior on bottomLeft  { PropertyAnimation { duration: Style.durations.small; easing.type: Easing.InOutQuad } }
      Behavior on bottomRight { PropertyAnimation { duration: Style.durations.small; easing.type: Easing.InOutQuad } }
      Behavior on topLeft  { PropertyAnimation { duration: Style.durations.small; easing.type: Easing.InOutQuad } }
      Behavior on topRight { PropertyAnimation { duration: Style.durations.small; easing.type: Easing.InOutQuad } }
      Rectangle {
        id: dot
        width: 4
        height: 4
        radius: 4
        y: 10
        SequentialAnimation on color {
          loops: Animation.Infinite
          running: root.active
          ColorAnimation {
            from: Style.srcery.brightWhite
            to: Style.srcery.gray3
            duration: Style.durations.slow
            easing.type: Easing.Linear
          }
          ColorAnimation {
            from: Style.srcery.gray3
            to: Style.srcery.brightWhite
            easing.type: Easing.Linear
            duration: Style.durations.slow
          }
        }
        // anchors.bottom: parent.bottom
        // anchors.bottomMargin: 4
        color: Style.srcery.brightBlack
        // anchors.centerIn: parent
        // anchors.topMargin: 4
        anchors.horizontalCenter: parent.horizontalCenter
      }
    }
    // Shape {
    //   id: shape
    //   anchors.centerIn: parent
    //   width: Style.bar.iconSize
    //   height: Style.bar.iconSize
    //   ShapePath {
    //     strokeWidth: 1
    //     id: path
    //     strokeColor: Style.srcery.gray3
    //     fillColor: Style.srcery.black
    //     PathSvg {
    //       id: svg
    //       path: "M 10 1.7 L 18.3 16.3 L 1.7 16.3 Z"
    //     }
    //   }
    // }
  }
}
