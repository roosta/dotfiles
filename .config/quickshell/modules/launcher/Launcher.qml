pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
// import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.config
import qs.utils
import qs
// import qs.utils
import qs.components
import qs.services

Item {
  id: root
  required property string monitorId

  anchors.fill: parent
  property bool monitorIsFocused: (Hyprland.focusedMonitor?.id === monitorId)
  property string query: ""
  property int currentIndex: 0


  BorderRectangle {
    id: launcher
    anchors.fill: parent
    anchors.horizontalCenter: parent.horizontalCenter
    color: Appearance.srcery.black
    topBorder: Appearance.bar.borderWidth
    borderColor: Appearance.srcery.gray2

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

      LauncherField {
        id: field
        onTextChanged: root.query = text
        monitorId: root.monitorId
        appList: layout.currentMenu?.item?.modelData ?? []
        parentWidth: parent.width
        onIncrementCurrentIndex: {
          layout.currentMenu?.item?.list.incrementCurrentIndex()
        }
        onDecrementCurrentIndex: {
          layout.currentMenu?.item?.list.decrementCurrentIndex()
        }
        onAccepted: {
          const currentItem = layout.currentMenu?.item?.list?.currentItem;
          if (currentItem) {
            layout.currentMenu.accept(currentItem.modelData)
          }
        }
      }
    }
  }
}
