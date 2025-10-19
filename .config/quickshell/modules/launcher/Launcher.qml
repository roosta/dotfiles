pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
// import QtQuick.Controls
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
  states: [
    State {
      name: "launcher-open"
      when: GlobalState.launcherOpen && GlobalState.activeMonitorId === root.monitorId
      PropertyChanges { content.color: Functions.transparentize("#000", 0.7) }
    }
  ]
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
      id: layout
      spacing: 0

      property QtObject currentList: {
        switch(state) {
          case "audio":
            return audioLoader.item
          case "display":
            return displayLoader.item
          default:
            return appLoader.item
        }
      }
      state: field.mode
      // TODO: Cleanup
      states: [
        State {
          name: "apps"
          PropertyChanges {
            // root.implicitWidth: Config.launcher.sizes.itemWidth
            // root.implicitHeight: Math.min(root.maxHeight, appLoader.implicitHeight > 0 ? appLoader.implicitHeight : empty.implicitHeight)
            appLoader.active: true
            appLoader.visible: true
            audioLoader.active: false
            audioLoader.visible: false
            displayLoader.active: false
            displayLoader.visible: false
          }

          // AnchorChanges {
          //   anchors.left: root.parent.left
          //   anchors.right: root.parent.right
          // }
        },
        State {
          name: "audio"
          PropertyChanges {
            audioLoader.active: true
            audioLoader.visible: true
            appLoader.active: false
            appLoader.visible: false
            displayLoader.active: false
            displayLoader.visible: false
          }
        },
        State {
          name: "display"
          PropertyChanges {
            displayLoader.active: true
            displayLoader.visible: true
            appLoader.active: false
            appLoader.visible: false
            audioLoader.active: false
            audioLoader.visible: false
          }
        }

      ]
      Loader {
        id: appLoader
        active: true
        visible: true
        Layout.fillWidth: true
        Layout.fillHeight: true
        sourceComponent: LauncherList {
          id: appList
          monitorId: root.monitorId
          searchQuery: root.query
          model: Apps.fuzzyQuery(root.query)
          signal accept(entry: DesktopEntry)
          onAccept: (entry) => {
            Apps.launch(entry)
            GlobalState.closeLauncher()
          }
          delegate: LauncherItem { 
            required property DesktopEntry modelData
            iconSource: Apps.getEntryIcon(modelData)
            name: modelData?.name ?? ""
            description: (modelData?.comment || modelData?.genericName || modelData?.name) ?? ""
            onClicked: appList.accept(modelData)
          }
          Favorites {}
        }
      }
      Loader {
        id: audioLoader
        active: false
        visible: false
        Layout.fillWidth: true
        Layout.fillHeight: true
        sourceComponent: LauncherList {
          id: audioList
          monitorId: root.monitorId
          searchQuery: root.query
          signal accept(entry: var)
          onAccept: (entry) => {
            Quickshell.execDetached({
              command: entry.script,
            });
            GlobalState.closeLauncher()
          }
          model: {
            const q = root.query.replace(Config.menus.audio.prefix, "")
            Audio.fuzzyQuery(q)
          }
          delegate: LauncherItem { 
            required property var modelData
            iconSource: Quickshell.iconPath(modelData.iconId)
            name: modelData.name
            description: modelData.description
            onClicked: audioList.accept(modelData)
          }
        }
      }
      Loader {
        id: displayLoader
        active: false
        visible: false
        Layout.fillWidth: true
        Layout.fillHeight: true
        sourceComponent: LauncherList {
          id: displayList
          monitorId: root.monitorId
          searchQuery: root.query
          signal accept(entry: var)
          onAccept: (entry) => {
            Quickshell.execDetached({
              command: entry.script,
            });
            GlobalState.closeLauncher()
          }
          model: {
            const q = root.query.replace(Config.menus.display.prefix, "")
            Display.fuzzyQuery(q)
          }
          delegate: LauncherItem { 
            required property var modelData
            iconSource: Quickshell.iconPath(modelData.iconId)
            name: modelData.name
            description: modelData.description
            onClicked: displayList.accept(modelData)
          }
        }
      }
      LauncherField {
        id: field
        onTextChanged: root.query = text
        monitorId: root.monitorId
        onIncrementCurrentIndex: {
          layout.currentList.list.incrementCurrentIndex()
        }
        onDecrementCurrentIndex: {
          layout.currentList.list.decrementCurrentIndex()
        }
        onAccepted: {
          const currentItem = layout.currentList.list?.currentItem;
          if (currentItem) {
            layout.currentList.accept(currentItem.modelData)
          } 
        }
      }


    }
  }
}
