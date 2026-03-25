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

pragma ComponentBehavior: Bound
import qs.config
// import qs.services
import qs.components
// import qs
import QtQuick
import QtQuick.Layouts

import QtQuick.Controls

BorderRectangle {
  id: root
  color: Appearance.srcery.black
  borderColor: Appearance.srcery.gray3
  borderWidth: Appearance.bar.borderWidth
  Layout.topMargin: Appearance.bar.borderWidth

  default property alias contents: layout.data
  required property string monitorId
  required property string buttonLabel
  property bool isEmpty: false;

  implicitWidth: {
    if (root.active) {
      return layout.implicitWidth + Appearance.spacing.p1 * 2

    } else {
      return layout.implicitWidth
    }
  }

  implicitHeight: Appearance.bar.height - Appearance.bar.borderWidth - Appearance.spacing.p1 * 2
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
      duration: Appearance.durations.small
      easing.type: Easing.InOutCubic
    }
  }
  states: [
    State {
      name: "default"
      when: !root.active && !button.hovered
      PropertyChanges { indicator.text: root.buttonLabel }
      PropertyChanges { buttonBg.borderColor: Appearance.srcery.gray3 }
    },
    State {
      name: "hovered"
      when: !root.active && button.hovered
      PropertyChanges { indicator.text: root.buttonLabel }
      PropertyChanges { buttonBg.borderColor: Appearance.srcery.gray6 }
    },
    State {
      name: "active"
      when: root.active && !button.hovered
      PropertyChanges { indicator.text: "❯" }
      PropertyChanges { buttonBg.borderColor: Appearance.srcery.gray3 }
    },
    State {
      name: "activeHovered"
      when: root.active && button.hovered
      PropertyChanges { root.borderColor: Appearance.srcery.gray6 }
      PropertyChanges { indicator.text: "❯" }
      PropertyChanges { buttonBg.borderColor: Appearance.srcery.gray6 }
    }
  ]

  RowLayout {
    id: layout
    spacing: Appearance.spacing.p3
    Button {
      id: button
      implicitHeight: root.height
      implicitWidth: root.height
      onPressed: {
        if (!root.isEmpty) {
          root.active = !root.active
        }
      }

      HoverHandler {
        id: hover
        cursorShape: Qt.PointingHandCursor
      }
      background: BorderRectangle {
        id: buttonBg
        color: Appearance.srcery.black
        borderWidth: Appearance.bar.borderWidth
        borderColor: Appearance.srcery.gray3
        Text {
          anchors.centerIn: parent
          id: indicator
          color: Appearance.srcery.white
          font {
            family: Appearance.font.light
            pixelSize: Appearance.font.size3
          }
        }
      }
    }
  }
}
