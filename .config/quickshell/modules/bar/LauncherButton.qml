import qs.services
import qs.config
import qs.utils
import QtQuick
// import QtQuick.Controls
import QtQuick.Layouts

import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets

Button {
  id: root
  property int size: 20

  // color: Appearance.srcery.brightWhite

  Layout.topMargin: Appearance.bar.borderWidth
  implicitWidth: parent.height - Appearance.spacing.p3
  implicitHeight: parent.height - Appearance.spacing.p3

  background: BorderRectangle {
    id: outerRect
    color: Appearance.srcery.black
    borderColor: Appearance.srcery.gray3
    borderWidth: Appearance.bar.borderWidth
    BorderRectangle {
      id: innerRect
      anchors.centerIn: parent
      implicitWidth: parent.width * 0.5
      implicitHeight: parent.height * 0.5
      borderWidth: Appearance.bar.borderWidth
      color: Appearance.srcery.black
      rotation: 45
      borderColor: Appearance.srcery.gray3
    }
  }

  states: [

    State {
      name: "pressed"
      when: root.pressed
      PropertyChanges { innerRect.rotation: 0 }
      PropertyChanges { innerRect.color: Appearance.srcery.brightWhite }
      PropertyChanges { outerRect.borderColor: Appearance.srcery.brightBlack }
      PropertyChanges { innerRect.borderColor: Appearance.srcery.brightWhite }
    },
    State {
      name: "hovered"
      when: root.hovered
      PropertyChanges { outerRect.borderColor: Appearance.srcery.gray6 }
      PropertyChanges { innerRect.rotation: 0 }
      PropertyChanges { innerRect.borderColor: Appearance.srcery.brightWhite }
    }
  ]

  transitions: [
    Transition {
      NumberAnimation { 
        properties: "rotation"
        duration: 200
        easing.type: Easing.InOutCubic
      }
      ColorAnimation { 
        duration: 50
        easing.type: Easing.OutQuad 
      }
    }
  ]
}
