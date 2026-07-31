// ┌────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█░░░█▀█░█░█░█▀█░█▀▀░█░█░█▀▀░█▀▄░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█░░░█▀█░█░█░█░█░█░░░█▀█░█▀▀░█▀▄░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>               ├┤
// ││ Repo    : https://github.com/roosta/dotfiles         ││
// ││ Site    : https://www.roosta.sh                      ││
// ├┤ License : GNU General Public License v3              ├┤
// ┆└──────────────────────────────────────────────────────┘┆

pragma ComponentBehavior: Bound

import qs
import qs.components
import qs.config
import qs.services
import qs.utils
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell

Item {
  id: root
  required property string monitorId

  anchors.bottomMargin: Style.bar.height
  anchors.bottom: parent.bottom
  anchors.left: parent.left
  anchors.right: parent.right

  // Constant height: nothing outside this item reflows while animating.
  implicitHeight: Style.launcher.height

  // Exposed for shell.qml — now constant, no per-frame churn.
  readonly property int launcherHeight: Style.launcher.height

  // The slide happens inside these bounds
  clip: true

  readonly property bool active: GlobalState.launcherOpen
    && GlobalState.launcherMonitorId === root.monitorId

  property bool monitorIsFocused: Hyprland.focusedMonitor?.id === monitorId

  // Only render while on-screen or mid-transition
  visible: launcher.y < Style.launcher.height

  signal decrementCurrentIndex()
  signal incrementCurrentIndex()
  signal drawerNext()
  signal drawerPrev()
  signal openDrawer()
  signal closeDrawer()
  signal drawerActivate()

  signal accepted()

  onDrawerActivate: {
    const currentItem = launcherList?.list?.currentItem;
    currentItem.drawerActivate()
  }
  onDrawerNext: {
    const currentItem = launcherList?.list?.currentItem;
    currentItem.drawerNext()
  }
  onDrawerPrev: {
    const currentItem = launcherList?.list?.currentItem;
    currentItem.drawerPrev()
  }
  onOpenDrawer: {
    const currentItem = launcherList?.list?.currentItem;
    currentItem.openDrawer()
  }
  onCloseDrawer: {
    const currentItem = launcherList?.list?.currentItem;
    currentItem.closeDrawer()
  }
  onAccepted: {
    const currentItem = launcherList?.list?.currentItem;
    if (currentItem) {
      launcherList.accept(currentItem.modelData)
    }
  }

  onIncrementCurrentIndex: {
    launcherList.list.incrementCurrentIndex()
  }

  onDecrementCurrentIndex: {
    launcherList.list.decrementCurrentIndex()
  }

  GlobalShortcut { // qmllint disable unresolved-type
    name: "toggleLauncher"
    description: "Toggles launcher"

    onPressed: {
      if (Hyprland.focusedMonitor?.name === root.monitorId) {
        GlobalState.toggleLauncher({ id: Hyprland.focusedMonitor?.name })
      }
    }
  }

  GlobalShortcut { // qmllint disable unresolved-type
    name: "toggleMenu"
    description: "Toggles launcher menu"

    onPressed: {
      if (Hyprland.focusedMonitor?.name === root.monitorId) {
        GlobalState.toggleLauncher({id: Hyprland.focusedMonitor?.name, mode: "menu"})
      }
    }
  }

  GlobalShortcut { // qmllint disable unresolved-type
    name: "toggleNotifications"
    description: "Toggles nofication launcher panel"

    onPressed: {
      if (Hyprland.focusedMonitor?.name === root.monitorId) {
        GlobalState.toggleLauncher({id: Hyprland.focusedMonitor?.name, mode: "notifications" })
      }
    }
  }

  GlobalShortcut { // qmllint disable unresolved-type
    name: "discardLastNotification"
    description: "Discards last notification"
    onPressed: {
      if (Hyprland.focusedMonitor?.name === root.monitorId) {
        Notifications.discardLastNotification();
      }
    }
  }

  BorderRect {
    id: launcher

    // Fixed geometry: the ColumnLayout / ListView never relayout during the animation
    anchors.left: parent.left
    anchors.right: parent.right
    implicitHeight: Style.launcher.height

    // 0 == fully open, Style.launcher.height == fully hidden below the bar
    y: root.active ? 0 : Style.launcher.height

    color: Style.srcery.black
    topBorder: Style.bar.borderWidth
    borderColor: Style.srcery.gray2

    Behavior on y {
      NumberAnimation {
        duration: Style.durations.small
        easing.type: Easing.InOutCubic
      }
    }

    ColumnLayout {
      anchors.fill: parent
      id: layout
      spacing: 0
      // This handles setting context description when launcher is open
      // TODO: Improve
      property string desc: launcherList?.list?.currentItem?.name ?? "Undefined"
      onDescChanged: {
        if (typeof desc === "string" && desc !== "Undefined") { ContextData.launcherDesc = desc }
      }

      property var sourceData: {
        const s = GlobalState.launcherMode
        if (s === "notifications") {
          const q = GlobalState.searchQuery.replace(`${Config.menuPrefix}/notifications`, "")
          return Fuzzy.go(q, Notifications.list, { all: true, key: "appName" }).map(s => s.obj)
        } else if (s === "menu") {
          const q = GlobalState.searchQuery.replace("/", "")
          return Fuzzy.query(q, LauncherData.menuData)
        } else if (s === "power") {
          const q = GlobalState.searchQuery.replace(`${Config.menuPrefix}/power`, "")
          return Fuzzy.query(q, LauncherData.powerData)
        } else if (s === "display") {
          const q = GlobalState.searchQuery.replace(`${Config.menuPrefix}/display`, "")
          return Fuzzy.query(q, LauncherData.displayData)
        } else if (s === "audio") {
          const q = GlobalState.searchQuery.replace(`${Config.menuPrefix}/audio`, "")
          return Fuzzy.query(q, LauncherData.audioData)
        } else if (s === "utils") {
          const q = GlobalState.searchQuery.replace(`${Config.menuPrefix}/utils`, "")
          return Fuzzy.query(q, LauncherData.utilsData)
        } else {
          return Fuzzy.query(GlobalState.searchQuery, LauncherData.appsData)
        }
      }

      onSourceDataChanged: {
        GlobalState.matchCount = layout.sourceData.length
      }

      function onAccept(entry) {
        const s = GlobalState.launcherMode
        if (s === "notifications") {
          Notifications.attemptInvokeAction(entry.notificationId, "default")
          GlobalState.closeLauncher()
        } else if (s === "menu") {
          GlobalState.launcherMode = entry.mode
          GlobalState.searchQuery = ""
        } else if (s === "power"
          || s === "display"
          || s === "audio"
          || s === "utils"
          || s === "apps"
          || s === "") {
          LauncherData.launch(entry)
          GlobalState.closeLauncher()
        }

      }

      LauncherList {
        monitorId: root.monitorId
        id: launcherList

        sourceModel: layout.sourceData

        signal accept(entry: var)
        onAccept: (entry) => {
          layout.onAccept(entry)
        }

        delegate: LauncherItem {
          required property var modelData

          iconSource: {
            const icon = modelData?.iconId || modelData?.appIcon
            if (icon) {
              return Quickshell.iconPath(icon)
            } else if (modelData?.id) {
              return Icons.getEntryIcon(modelData)
            }
            return ""
          }

          notificationId: modelData?.notificationId ?? -1
          imageSource: modelData?.image ?? ""
          name: modelData?.name ?? modelData?.appName ?? ""
          favorite: Config.favorites.includes(modelData?.id ?? "") ?? false
          isNotification: modelData?.isNotification ?? false
          timeElapsed: Functions.timeElapsed(modelData?.time) ?? ""
          description: modelData?.comment ?? modelData?.body ?? ""
          genericName: modelData?.genericName ?? modelData?.summary ??  ""
          actions: modelData?.actions ?? []
          categories: modelData?.categories ?? []
          onClicked: launcherList.accept(modelData)
        }
      }

      // Silence warnings about property access
      // Due to the currrentMenu being sort of generic I dont know how to let qmllint
      // know about these properties, but they are there
      // LauncherField {
      //   id: field
      //   onTextChanged: root.query = text
      //   monitorId: root.monitorId
      //   // qmllint disable missing-property
      //   appList: layout.currentMenu?.item?.modelData ?? []
      //   parentWidth: parent.width
      //   onIncrementCurrentIndex: {
      //     // qmllint disable missing-property
      //     // layout.currentMenu?.item?.list.incrementCurrentIndex()
      //   }
      //   onDecrementCurrentIndex: {
      //     // qmllint disable missing-property
      //     // layout.currentMenu?.item?.list.decrementCurrentIndex()
      //   }
      //   onAccepted: {
      //     const currentItem = layout.currentMenu?.item?.list?.currentItem; // qmllint disable missing-property
      //     if (currentItem) {
      //       // qmllint disable missing-property
      //       layout.currentMenu.accept(currentItem.modelData)
      //     }
      //   }
      // }
    }
  }
}
