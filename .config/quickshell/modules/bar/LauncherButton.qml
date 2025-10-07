import qs.services
import qs.config
import qs.utils
import qs.components
import qs
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets

Button {
  id: root

  // color: Appearance.srcery.brightWhite
  required property string monitorId
  Layout.topMargin: Appearance.bar.borderWidth
  implicitWidth: parent.height - Appearance.spacing.p3
  implicitHeight: parent.height - Appearance.spacing.p3

  onPressed: {
    GlobalState.toggleLauncher(root.QsWindow.window?.screen?.name)
  }

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
      name: "active"
      when: GlobalState.launcherOpen && GlobalState.activeMonitorId === root.monitorId
      PropertyChanges { innerRect.rotation: 0 }
      PropertyChanges { outerRect.borderColor: Appearance.srcery.brightWhite }
      PropertyChanges { innerRect.borderColor: Appearance.srcery.brightWhite }
    },
    State {
      name: "hovered"
      when: root.hovered
      PropertyChanges { outerRect.borderColor: Appearance.srcery.gray6 }
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
