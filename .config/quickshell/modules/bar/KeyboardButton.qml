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

  implicitWidth: layout.implicitWidth
  implicitHeight: Appearance.bar.height - Appearance.spacing.p3

  Behavior on implicitWidth {
    NumberAnimation {
      duration: Appearance.durations.small
      easing.type: Easing.InOutCubic
    }
  }
  states: [
    State {
      name: "hovered"
      when: button.hovered && !button.pressed
      PropertyChanges { root.borderColor: Appearance.srcery.gray4 }
    },
    State {
      name: "pressed"
      when: button.pressed && button.hovered
      PropertyChanges { root.borderColor: Appearance.srcery.gray6 }
    }
  ]

  RowLayout {
    id: layout
    spacing: 0
    Button {
      id: button
      implicitWidth: root.height
      onPressed: Keyboard.nextLayout()

      HoverHandler {
        id: hover
        cursorShape: Qt.PointingHandCursor
      }
      contentItem: Text {
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        id: indicator
        text: Keyboard.layout.code.toUpperCase()
        color: Keyboard.layout.color
        font {
          family: Appearance.font.light
          pixelSize: Appearance.font.size3
        }
      }

      background: Rectangle {
        id: buttonBg
        color: "transparent"
        
      }
    }
    Rectangle {
      id: shiftlock
      visible: Keyboard.capsLock
      color: "transparent"
      implicitWidth: root.height - Appearance.spacing.p3 + Appearance.bar.borderWidth
      Layout.fillHeight: true
      Text {
        text: "󰌾"

        anchors.verticalCenter: parent.verticalCenter
        color: Appearance.srcery.yellow
        font {
          family: Appearance.font.light
          pixelSize: Appearance.font.size2
        }
      }
    }
  }
}
