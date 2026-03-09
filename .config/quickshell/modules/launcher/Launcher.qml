pragma ComponentBehavior: Bound

import qs
import qs.components
import qs.config
import qs.services
import qs.utils
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

// import qs.utils
// import QtQuick.Controls
// import Quickshell

Item {
  id: root
  required property string monitorId

  anchors.bottomMargin: Appearance.bar.height
  anchors.fill: parent
  property bool monitorIsFocused: (Hyprland.focusedMonitor?.id === monitorId)
  property string query: ""
  property int currentIndex: 0

  visible: launcher.height > 0

  GlobalShortcut { // qmllint disable unresolved-type
    name: "toggleLauncher"
    description: "Toggles launcher"

    onPressed: {

      if (Hyprland.focusedMonitor?.name === root.monitorId) {
        GlobalState.toggleLauncher(Hyprland.focusedMonitor?.name)
      }
    }
  }
  GlobalShortcut { // qmllint disable unresolved-type
    name: "toggleNotifications"
    description: "Toggles nofication launcher panel"

    onPressed: {

      if (Hyprland.focusedMonitor?.name === root.monitorId) {
        GlobalState.toggleLauncher(Hyprland.focusedMonitor?.name, "notifications")
      }
    }
  }
  BorderRectangle {
    id: launcher
    implicitHeight: 0
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    color: Appearance.srcery.black
    topBorder: Appearance.bar.borderWidth
    borderColor: Appearance.srcery.gray2

    states: [
      State {
        name: "active"
        when: GlobalState.launcherOpen && GlobalState.launcherMonitorId === root.monitorId
        PropertyChanges { launcher.implicitHeight: Appearance.launcher.height }
      }
    ]

    transitions: [
      Transition {
        NumberAnimation {
          properties: "implicitHeight"
          duration: Appearance.durations.small
          easing.type: Easing.InOutCubic
        }
      }
    ]

    ColumnLayout {
      anchors.fill: parent
      id: layout
      spacing: 0

      property QtObject currentMenu: {
        switch(state) {
          case "audio":
            return audioMenu
          case "display":
            return displayMenu
          case "power":
            return powerMenu
          case "utils":
            return utilsMenu
          case "menu":
            return menuMenu
          case "notifications":
            return notificationMenu
          default:
            return appMenu
        }
      }


      // This handles setting context description when launcher is open
      // TODO: Improve
      property string desc: currentMenu?.item?.list?.currentItem?.name ?? "Undefined"
      onDescChanged: {
        if (typeof desc === "string" && desc !== "Undefined") { ContextData.launcherDesc = desc }
      }

      state: GlobalState.launcherMode

      // Applications
      LauncherMenu {
        id: appMenu
        active: layout.state === "apps" || layout.state === ""
        query: root.query
        monitorId: root.monitorId
        sourceModel: Fuzzy.query(root.query, LauncherData.appsData)
        onAccept: (entry) => {
          LauncherData.launch(entry)
          GlobalState.closeLauncher()
        }
      }


      // Notifications
      LauncherMenu {
        id: notificationMenu
        active: layout.state === "notifications"
        query: root.query
        monitorId: root.monitorId
        sourceModel: {
          const q = root.query.replace(`${Config.menuPrefix}/notifications`, "")
          return Fuzzy.go(root.query, Notifications.list, {
            all: true,
            key: "appName"

          }).map(s => s.obj)
        }
        onAccept: (entry) => {
          // LauncherData.launch(entry)
          GlobalState.closeLauncher()
        }
      }

      // Utilities (scripts)
      LauncherMenu {
        id: utilsMenu
        active: layout.state === "utils"
        query: root.query
        monitorId: root.monitorId
        sourceModel: {
          const q = root.query.replace(`${Config.menuPrefix}/utils`, "")
          return Fuzzy.query(q, LauncherData.utilsData)
        }
        onAccept: (entry) => {
          LauncherData.launch(entry)
          GlobalState.closeLauncher()
        }
      }

      // Audio menu
      LauncherMenu {
        id: audioMenu
        active: layout.state === "audio"
        query: root.query
        monitorId: root.monitorId
        sourceModel: {
          const q = root.query.replace(`${Config.menuPrefix}/audio`, "")
          return Fuzzy.query(q, LauncherData.audioData)
        }
        onAccept: (entry) => {
          LauncherData.launch(entry)
          GlobalState.closeLauncher()
        }
      }

      // Display menu
      LauncherMenu {
        id: displayMenu
        active: layout.state === "display"
        query: root.query
        monitorId: root.monitorId
        sourceModel: {
          const q = root.query.replace(`${Config.menuPrefix}/display`, "")
          return Fuzzy.query(q, LauncherData.displayData)
        }
        onAccept: (entry) => {
          LauncherData.launch(entry)
          GlobalState.closeLauncher()
        }
      }

      // Power menu
      LauncherMenu {
        id: powerMenu
        active: layout.state === "power"
        query: root.query
        monitorId: root.monitorId
        sourceModel: {
          const q = root.query.replace(`${Config.menuPrefix}/power`, "")
          return Fuzzy.query(q, LauncherData.powerData)
        }
        onAccept: (entry) => {
          LauncherData.launch(entry)
          GlobalState.closeLauncher()
        }
      }

      LauncherMenu {
        id: menuMenu
        active: layout.state === "menu"
        query: root.query
        monitorId: root.monitorId
        sourceModel: {
          const q = root.query.replace("/", "")
          Fuzzy.query(q, LauncherData.menuData)
        }
        onAccept: (entry) => {
          GlobalState.launcherMode = entry.mode
          field.text = ""
        }
      }

      // Silence warnings about property access
      // Due to the currrentMenu being sort of generic I dont know how to let qmllint
      // know about these properties, but they are there
      LauncherField {
        id: field
        onTextChanged: root.query = text
        monitorId: root.monitorId
        // qmllint disable missing-property
        appList: layout.currentMenu?.item?.modelData ?? []
        parentWidth: parent.width
        onIncrementCurrentIndex: {
          // qmllint disable missing-property
          layout.currentMenu?.item?.list.incrementCurrentIndex()
        }
        onDecrementCurrentIndex: {
          // qmllint disable missing-property
          layout.currentMenu?.item?.list.decrementCurrentIndex()
        }
        onAccepted: {
          const currentItem = layout.currentMenu?.item?.list?.currentItem; // qmllint disable missing-property
          if (currentItem) {
            // qmllint disable missing-property
            layout.currentMenu.accept(currentItem.modelData)
          }
        }
      }
    }
  }
}
