// ┌────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█░█░█▀▀░█░█░█▀▄░█▀█░█▀█░█▀▄░█▀▄░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█▀▄░█▀▀░░█░░█▀▄░█░█░█▀█░█▀▄░█░█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀░▀░▀▀▀░░▀░░▀▀░░▀▀▀░▀░▀░▀░▀░▀▀░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>               ├┤
// ││ Repo    : https://github.com/roosta/dotfiles         ││
// ││ Site    : https://www.roosta.sh                      ││
// ├┤ License : GNU General Public License v3              ├┤
// ┆└──────────────────────────────────────────────────────┘┆

pragma ComponentBehavior: Bound
import qs.config
import qs.services
import qs.components
import QtQuick
import QtQuick.Layouts

// import QtQuick.Controls

BorderRect {
  id: root
  color: Style.srcery.black
  borderColor: Style.srcery.gray3
  borderWidth: Style.bar.borderWidth
  Layout.topMargin: Style.bar.borderWidth

  required property string monitorId

  implicitWidth: layout.implicitWidth + Style.spacing.p1 * 2
  implicitHeight: Style.bar.height - Style.bar.borderWidth
    - Style.spacing.p1 * 2

  Behavior on implicitWidth {
    NumberAnimation {
      duration: Style.durations.small
      easing.type: Easing.InOutCubic
    }
  }

  MouseArea {
    id: button
    hoverEnabled: true
    anchors.fill: parent
    onClicked: {
      Keyboard.nextLayout()
    }
  }

  states: [
    State {
      name: "hovered"
      when: button.containsMouse && !button.pressed
      PropertyChanges { root.borderColor: Style.srcery.gray4 }
      PropertyChanges { button.cursorShape: Qt.PointingHandCursor }
    },
    State {
      name: "pressed"
      when: button.pressed && button.containsMouse
      PropertyChanges { root.borderColor: Style.srcery.gray6 }
      PropertyChanges { button.cursorShape: Qt.PointingHandCursor }
    }
  ]

  RowLayout {
    id: layout
    spacing: Style.spacing.p1
    anchors.fill: parent
    anchors.leftMargin: Style.spacing.p1
    anchors.rightMargin: Style.spacing.p1
    Rectangle {
      Layout.preferredWidth: Style.font.size3
      Layout.preferredHeight: Style.font.size3
      color: "transparent"

      Text {
        anchors.centerIn: parent
        id: indicator
        text: Keyboard.layout.code.toUpperCase()
        color: Keyboard.layout.color
        font {
          family: Style.font.light
          pixelSize: Style.font.size3
        }
      }
    }
    Rectangle {
      id: shiftlock
      visible: Keyboard.capsLock
      color: "transparent"
      Layout.preferredWidth: Style.font.size3
      Layout.preferredHeight: Style.font.size3
      Text {
        text: "󰌾"
        anchors.centerIn: parent
        color: Style.srcery.yellow
        font {
          family: Style.font.light
          pixelSize: Style.font.size3
        }
      }
    }
  }
}
