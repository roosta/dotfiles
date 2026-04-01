// ┌────────────────────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█░░░█▀█░█░█░█▀█░█▀▀░█░█░█▀▀░█▀▄░█▄█░█▀▀░█▀█░█░█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█░░░█▀█░█░█░█░█░█░░░█▀█░█▀▀░█▀▄░█░█░█▀▀░█░█░█░█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░▀░▀▀▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>                               ├┤
// ││ Repo    : https://github.com/roosta/dotfiles                         ││
// ││ Site    : https://www.roosta.sh                                      ││
// ├┤ License : GNU General Public License v3                              ├┤
// ┆└──────────────────────────────────────────────────────────────────────┘┆

pragma ComponentBehavior: Bound
import Quickshell
import QtQuick.Layouts
import Quickshell.Widgets
import QtQuick
import qs.config
import qs.components
import qs.services
import qs.utils
import qs

Loader {
  id: root
  required property string monitorId
  required property var sourceModel
  required property string query
  property bool canClose
  visible: active

  Layout.fillWidth: true
  Layout.fillHeight: true

  signal accept(entry: var)

  sourceComponent: LauncherList {
    id: list
    monitorId: root.monitorId
    searchQuery: root.query

    sourceModel: root.sourceModel
    delegate: LauncherItem {
      required property var modelData

      parentWidth: list.width
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
      onClicked: root.accept(modelData)
    }
  }
}
