pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.config
import qs
import qs.utils
import qs.components
import qs.services

Item {
  id: root
  required property string monitorId
  visible: launcher.height > 0

  anchors.fill: parent
  anchors.bottomMargin: Appearance.bar.height + Appearance.spacing.p1
  property bool monitorIsFocused: (Hyprland.focusedMonitor?.id === monitorId)
  property string query: ""
  property int currentIndex: 0
  property ListWrapper currentList: appList.item

  state: "apps"
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
    borderWidth: Appearance.bar.borderWidth
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
      },
      State {
        name: "apps"

        PropertyChanges {
          // root.implicitWidth: Config.launcher.sizes.itemWidth
          // root.implicitHeight: Math.min(root.maxHeight, appList.implicitHeight > 0 ? appList.implicitHeight : empty.implicitHeight)
          appList.active: true
        }

        // AnchorChanges {
        //   anchors.left: root.parent.left
        //   anchors.right: root.parent.right
        // }
      },
      State {
        name: "audio"

        // PropertyChanges {
        //   root.implicitWidth: Math.max(Config.launcher.sizes.itemWidth * 1.2, wallpaperList.implicitWidth)
        //   root.implicitHeight: Config.launcher.sizes.wallpaperHeight
        //   wallpaperList.active: true
        // }
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
      Loader {
        id: appList
        active: true
        Layout.fillWidth: true
        Layout.fillHeight: true
        sourceComponent: AppList {
          monitorId: root.monitorId
          searchQuery: root.query
        }
      }
      LauncherField {
        onTextChanged: root.query = text
        onIncrementCurrentIndex: {
          root.currentList.list.incrementCurrentIndex()
        }
        onDecrementCurrentIndex: {
          root.currentList.list.decrementCurrentIndex()
        }
        onAccepted: {
          const currentItem = root.currentList.list?.currentItem;
          if (currentItem) {
            Apps.launch(currentItem.modelData);
            GlobalState.closeLauncher()
          }
        }
      }


    }
  }
}
