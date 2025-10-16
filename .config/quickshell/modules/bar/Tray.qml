// import qs.services
pragma ComponentBehavior: Bound
import qs.config
// import qs.utils
import qs.components
import QtQuick
// import QtQuick.Controls
import QtQuick.Layouts
// import QtQuick.Shapes
import Quickshell.Services.SystemTray

import QtQuick.Controls
// import Quickshell
// import Quickshell.Hyprland
// import Quickshell.Wayland
// import Quickshell.Widgets

BorderRectangle {
  id: root
  color: Appearance.srcery.black
  borderColor: Appearance.srcery.gray3
  borderWidth: Appearance.bar.borderWidth
  Layout.topMargin: Appearance.bar.borderWidth
  implicitWidth: layout.implicitWidth
  implicitHeight: Appearance.bar.height - Appearance.spacing.p3
  property bool active: false

    // MouseArea {
    //   anchors.fill: parent
    //   hoverEnabled: true
    //   id: mouse
    //   cursorShape: Qt.PointingHandCursor
    //   onClicked: {
    //     if (!root.active) {
    //       root.active = true
    //     }
    //   }
    // }
  states: [
    State {
      name: "active"
      when: root.active
      PropertyChanges { indicator.color: Appearance.srcery.white }
      PropertyChanges {  indicator.text: "❯" }
    },
    State {
      name: "hovered"
      when: button.hovered
      PropertyChanges { buttonBg.borderColor: Appearance.srcery.gray6 }
      PropertyChanges { indicator.color: Appearance.srcery.white }
    }
  ]

  RowLayout {
    id: layout
    spacing: Appearance.spacing.p2
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
          text: SystemTray.items.values.length
          color: Appearance.srcery.brightBlack
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
