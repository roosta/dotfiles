import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.config
import qs
import qs.utils
import qs.components

Item {
  id: root
  required property string monitorId
  visible: launcher.height > 0

  anchors.fill: parent
  anchors.bottomMargin: Appearance.bar.height + Appearance.spacing.p1
  property bool monitorIsFocused: (Hyprland.focusedMonitor?.id === monitorId)

  GlobalShortcut {
    name: "toggleLauncher"
    description: "Toggles launcher"

    onPressed: {

      if (Hyprland.focusedMonitor?.name === root.monitorId) {
        GlobalState.toggleLauncher(Hyprland.focusedMonitor?.name)
      }
    }
  }
  MouseArea {
    anchors.fill: parent
    onClicked: {
      GlobalState.closeLauncher()
    }
  }

  states: [
    State {
      name: "launcher-open"
      when: GlobalState.launcherOpen && GlobalState.activeMonitorId === root.monitorId
      PropertyChanges { content.color: Functions.transparentize("#000", 0.7) }
    }
  ]
  transitions: [
    Transition {
      ColorAnimation { 
        duration: 300
        easing.type: Easing.OutQuad 
      }
    }
  ]
  BorderRectangle {
    id: launcher
    implicitWidth: Appearance.launcher.width
    gradientAngle: 45
    anchors.bottom: parent.bottom
    implicitHeight: 0
    anchors.horizontalCenter: parent.horizontalCenter
    color: Appearance.srcery.black
    borderWidth: 1
    borderGradient: Gradient {
      orientation: Gradient.Horizontal
      GradientStop { position: 0; color: Appearance.srcery.magenta }
      GradientStop { position: 1; color: Appearance.srcery.blue }
    }

    states: [
      State {
        name: "active"
        when: GlobalState.launcherOpen && GlobalState.activeMonitorId === root.monitorId
        PropertyChanges { launcher.implicitHeight: Appearance.launcher.height }
      }
    ]
    transitions: [
      Transition {
        NumberAnimation { 
          properties: "implicitHeight"
          duration: 200
          easing.type: Easing.InOutCubic
        }
      }
    ]
    MouseArea {
      anchors.fill: parent
      onClicked: {
        // Consume the click event to prevent it from reaching the parent MouseArea
      }
    }
    ColumnLayout {
      anchors.fill: parent
      spacing: 0
      AppList { 
        search: search
      }
      BorderRectangle {
        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: true
        color: Appearance.srcery.black
        topBorder: Appearance.bar.borderWidth
        Layout.leftMargin: Appearance.bar.borderWidth
        Layout.rightMargin: Appearance.bar.borderWidth
        Layout.bottomMargin: Appearance.bar.borderWidth
        borderColor: Appearance.srcery.gray3
        Layout.preferredHeight: search.implicitHeight + Appearance.spacing.p4 * 2
        SearchField {
          id: search
          monitorId: root.monitorId
          anchors.centerIn: parent
          anchors.margins: Appearance.spacing.p4
          Keys.onEscapePressed: GlobalState.closeLauncher()
        }
      }
    }
  }
}
