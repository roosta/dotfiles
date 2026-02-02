pragma ComponentBehavior: Bound
import qs.config
import qs.services
import qs.components
import QtQuick
import QtQuick.Layouts

import QtQuick.Controls

BorderRectangle {
  id: root
  color: Appearance.srcery.black
  borderColor: Appearance.srcery.gray3
  borderWidth: Appearance.bar.borderWidth
  Layout.topMargin: Appearance.bar.borderWidth

  required property string monitorId

  implicitWidth: layout.implicitWidth + Appearance.spacing.p1 * 2
  implicitHeight: Appearance.bar.height - Appearance.bar.borderWidth - Appearance.spacing.p1 * 2

  Behavior on implicitWidth {
    NumberAnimation {
      duration: Appearance.durations.small
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
      PropertyChanges { root.borderColor: Appearance.srcery.gray4 }
      PropertyChanges { button.cursorShape: Qt.PointingHandCursor }
    },
    State {
      name: "pressed"
      when: button.pressed && button.containsMouse
      PropertyChanges { root.borderColor: Appearance.srcery.gray6 }
      PropertyChanges { button.cursorShape: Qt.PointingHandCursor }
    }
  ]

  RowLayout {
    id: layout
    spacing: Appearance.spacing.p1
    anchors.fill: parent
    anchors.leftMargin: Appearance.spacing.p1
    anchors.rightMargin: Appearance.spacing.p1
    Rectangle {
      Layout.preferredWidth: Appearance.font.size3
      Layout.preferredHeight: Appearance.font.size3
      color: "transparent"

      Text {
        anchors.centerIn: parent
        id: indicator
        text: Keyboard.layout.code.toUpperCase()
        color: Keyboard.layout.color
        font {
          family: Appearance.font.light
          pixelSize: Appearance.font.size3
        }
      }
    }
    Rectangle {
      id: shiftlock
      visible: Keyboard.capsLock
      color: "transparent"
      Layout.preferredWidth: Appearance.font.size3
      Layout.preferredHeight: Appearance.font.size3
      Text {
        text: "󰌾"
        anchors.centerIn: parent
        color: Appearance.srcery.yellow
        font {
          family: Appearance.font.light
          pixelSize: Appearance.font.size3
        }
      }
    }
  }
}
