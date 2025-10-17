pragma ComponentBehavior: Bound
import qs.config
import qs.components
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

import QtQuick.Controls

BorderRectangle {
  id: root
  color: Appearance.srcery.black
  borderColor: Appearance.srcery.gray3
  borderWidth: Appearance.bar.borderWidth
  Layout.topMargin: Appearance.bar.borderWidth
  implicitWidth: {

    if (root.active) {
      return layout.implicitWidth + Appearance.spacing.p3
    } else {
      return layout.implicitWidth
    }
  }

  implicitHeight: Appearance.bar.height - Appearance.spacing.p3
  property bool active: false

  onActiveChanged: {
    if (root.active) {
      timer.restart()
    }
  }

  // Automatically close after 30 seconds
  // TODO: Should be open when menu is visible, or inside mouse area
  Timer {
    id: timer
    interval: 1000 * 30
    onTriggered: {
      root.active = false
    }
  }
  Behavior on implicitWidth {
    NumberAnimation {
      duration: 200
      easing.type: Easing.InOutCubic
    }
  }
  states: [
    State {
      name: "default"
      when: !root.active && !button.hovered
      PropertyChanges { indicator.text: SystemTray.items.values.length }
      PropertyChanges { buttonBg.borderColor: Appearance.srcery.gray3 }
    },
    State {
      name: "hovered"
      when: !root.active && button.hovered
      PropertyChanges { indicator.text: SystemTray.items.values.length }
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
        root.active = !root.active
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
    Repeater {
      id: items
      model: root.active ? SystemTray.items : null
      visible: root.active
      TrayItem {}
    }
  }
}
