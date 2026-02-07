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

      property QtObject currentList: {
        switch(state) {
          case "audio":
          return audioLoader.item
          case "display":
          return displayLoader.item
          case "power":
          return powerLoader.item
          case "menu":
          return menuLoader.item
          default:
          return appLoader.item
        }
      }
      property string desc: currentList?.list?.currentItem?.name ?? "Undefined"
      onDescChanged: {
        if (typeof desc === "string" && desc !== "Undefined") { ContextData.launcherDesc = desc }
      }
      state: GlobalState.launcherMode
      Loader {
        id: appLoader
        active: layout.state === "apps" || layout.state === ""
        visible: active
        Layout.fillWidth: true
        Layout.fillHeight: true
        sourceComponent: LauncherList {
          id: appList
          monitorId: root.monitorId
          searchQuery: root.query
          sourceModel: Apps.fuzzyQuery(root.query)
          signal accept(entry: DesktopEntry)
          onAccept: (entry) => {
            Apps.launch(entry)
            GlobalState.closeLauncher()
          }
          delegate: LauncherItem {
            required property DesktopEntry modelData

            parentWidth: appList.width
            iconSource: Apps.getEntryIcon(modelData)
            name: modelData?.name
            favorite: modelData?.favorite
            description: modelData?.comment
            genericName: modelData?.genericName
            categories: modelData?.categories
            onClicked: appList.accept(modelData)
          }
          // Favorites {}
        }
      }
      Loader {
        id: audioLoader
        active: layout.state === "audio"
        visible: active
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
          sourceModel: {
            const q = root.query.replace(Config.menus.audio.prefix, "")
            Audio.fuzzyQuery(q)
          }
          delegate: LauncherItem {
            required property var modelData
            iconSource: Quickshell.iconPath(modelData.iconId)
            name: modelData.name
            description: modelData.description
            genericName: modelData?.genericName
            categories: modelData?.categories
            onClicked: audioList.accept(modelData)
          }
        }
      }
      Loader {
        id: displayLoader
        active: layout.state === "display"
        visible: active
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
          sourceModel: {
            const q = root.query.replace(Config.menus.display.prefix, "")
            Display.fuzzyQuery(q)
          }
          delegate: LauncherItem {
            required property var modelData
            iconSource: Quickshell.iconPath(modelData.iconId)
            name: modelData.name
            description: modelData.description
            parentWidth: displayList.width
            genericName: modelData?.genericName
            categories: modelData?.categories
            onClicked: displayList.accept(modelData)
          }
        }
      }
      Loader {
        id: powerLoader
        active: layout.state === "power"
        visible: active
        Layout.fillWidth: true
        Layout.fillHeight: true
        sourceComponent: LauncherList {
          id: powerList
          monitorId: root.monitorId
          searchQuery: root.query
          signal accept(entry: var)
          onAccept: (entry) => {
            Quickshell.execDetached({
              command: entry.script,
            });
            GlobalState.closeLauncher()
          }
          sourceModel: {
            const q = root.query.replace(Config.menus.power.prefix, "")
            Power.fuzzyQuery(q)
          }
          delegate: LauncherItem {
            required property var modelData
            iconSource: Quickshell.iconPath(modelData.iconId)
            name: modelData.name
            parentWidth: powerList.width
            description: modelData.description
            genericName: modelData?.genericName
            categories: modelData?.categories
            onClicked: powerList.accept(modelData)
          }
        }
      }
      Loader {
        id: menuLoader
        active: layout.state === "menu"
        visible: active
        Layout.fillWidth: true
        Layout.fillHeight: true
        sourceComponent: LauncherList {
          id: menuList
          monitorId: root.monitorId
          searchQuery: root.query
          signal accept(entry: var)
          onAccept: (entry) => {
            GlobalState.launcherMode = entry.mode
            field.text = ""
          }
          sourceModel: {
            const q = root.query.replace("/", "")
            Menu.fuzzyQuery(q)
          }
          delegate: LauncherItem {
            required property var modelData
            iconSource: Quickshell.iconPath(modelData.iconId)
            name: modelData.name
            parentWidth: menuList.width
            description: modelData.description
            genericName: modelData?.genericName
            categories: modelData?.categories
            onClicked: menuList.accept(modelData)
          }
        }
      }
      LauncherField {
        id: field
        onTextChanged: root.query = text
        // Layout.alignment: Qt.AlignHCenter
        monitorId: root.monitorId
        appList: layout.currentList?.modelData ?? []
        parentWidth: parent.width
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
