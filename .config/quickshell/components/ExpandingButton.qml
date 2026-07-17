// ┌──────────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█▀▀░█░█░█▀█░░░█▀▄░█░█░▀█▀░▀█▀░█▀█░█▀█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█▀▀░▄▀▄░█▀▀░░░█▀▄░█░█░░█░░░█░░█░█░█░█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀▀▀░▀░▀░▀░░░░░▀▀░░▀▀▀░░▀░░░▀░░▀▀▀░▀░▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀──────────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>                     ├┤
// ││ Repo    : https://github.com/roosta/dotfiles               ││
// ││ Site    : https://www.roosta.sh                            ││
// ├┤ License : GNU General Public License v3                    ├┤
// ┆└────────────────────────────────────────────────────────────┘┆

// Description: Its a button that is placed on the Bar, and it expands when
// left clicking, showing detailed content. For example, in AudioButton.qml I
// keep the volume bar and input indicator collapsed, only visible when this is
// expanded.
//
// Requires a monitorId and a button label, and you can optionally implement the click handlers

pragma ComponentBehavior: Bound
import qs.config
// import qs.services
import qs.components
// import qs
import QtQuick
import QtQuick.Layouts

import QtQuick.Controls

BorderRect {
  id: root
  clip: true
  color: Style.srcery.black
  borderColor: Style.srcery.gray3
  borderWidth: Style.bar.borderWidth
  Layout.topMargin: Style.bar.borderWidth

  default property alias contents: layout.data
  required property string monitorId
  required property string buttonLabel
  property var onRightClick: () => {
    // console.log("right click")
  }
  property bool isEmpty: false;

  property var onLeftClick: () => {
    if (!root.isEmpty) {
      root.active = !root.active
    }
  }

  implicitWidth: {
    if (root.active) {
      return layout.implicitWidth + Style.spacing.p1 * 2

    } else {
      return layout.implicitWidth
    }
  }

  implicitHeight: Style.bar.height - Style.bar.borderWidth - Style.spacing.p1 * 2
  property bool active: false
  property bool preventAutoClose: false

  onIsEmptyChanged: {
    if (root.isEmpty) {
      root.active = false
    }
  }
  onActiveChanged: {
    if (root.active) {
      timer.restart()
    }
  }

  onPreventAutoCloseChanged: {
    if (!root.preventAutoClose && root.active) {
      timer.restart()
    } else if (root.preventAutoClose) {
      timer.stop()
    }
  }

  // Automatically close after 30 seconds
  // TODO: Should be open when mouse is inside mouse area
  Timer {
    id: timer
    interval: 1000 * 30
    onTriggered: {
      if (!root.preventAutoClose) {
        root.active = false
      }
    }
  }
  Behavior on implicitWidth {
    NumberAnimation {
      duration: Style.durations.small
      easing.type: Easing.InOutCubic
    }
  }
  states: [
    State {
      name: "default"
      when: !root.active && !button.hovered
      PropertyChanges { indicator.text: root.buttonLabel }
      PropertyChanges { buttonBg.borderColor: Style.srcery.gray3 }
    },
    State {
      name: "hovered"
      when: !root.active && button.hovered
      PropertyChanges { indicator.text: root.buttonLabel }
      PropertyChanges { buttonBg.borderColor: Style.srcery.gray6 }
    },
    State {
      name: "active"
      when: root.active && !button.hovered
      PropertyChanges { indicator.text: "❯" }
      PropertyChanges { buttonBg.borderColor: Style.srcery.gray3 }
    },
    State {
      name: "activeHovered"
      when: root.active && button.hovered
      PropertyChanges { root.borderColor: Style.srcery.gray6 }
      PropertyChanges { indicator.text: "❯" }
      PropertyChanges { buttonBg.borderColor: Style.srcery.gray6 }
    }
  ]

  RowLayout {
    id: layout
    spacing: Style.spacing.p3
    Button {
      id: button
      implicitHeight: root.height

      MouseArea {
        id: mouseArea
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: (mouse) => {
          if (mouse.button === Qt.RightButton) {
            root.onRightClick()
          } else if (mouse.button === Qt.LeftButton) {
            root.onLeftClick()
          }
        }
      }
      implicitWidth: root.height
      background: BorderRect {
        id: buttonBg
        color: Style.srcery.black
        borderWidth: Style.bar.borderWidth
        borderColor: Style.srcery.gray3
        Text {
          anchors.centerIn: parent
          id: indicator
          color: Style.srcery.white
          font {
            family: Style.font.light
            pixelSize: Style.font.size3
          }
        }
      }
    }
  }
}
