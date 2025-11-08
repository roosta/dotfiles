pragma ComponentBehavior: Bound
import qs.config
import qs.services
import qs.components
import qs
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

  // Automatically close after 30 seconds
  // TODO: Should be open when menu is visible, or inside mouse area
  Timer {
    id: timer
    interval: 1000 * 30
    onTriggered: {
      // root.active = false
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
      name: "hovered"
      when: button.hovered
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
        console.log("I got pressed!")
        // root.active = !root.active
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
          text: "EN"
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
