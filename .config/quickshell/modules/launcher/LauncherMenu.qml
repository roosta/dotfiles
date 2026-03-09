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
  required property bool active
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
        if (modelData?.iconId) {
         return Quickshell.iconPath(modelData.iconId)
       } else if (modelData?.id) {
         return Icons.getEntryIcon(modelData)
       }
       return ""
      }

      notificationId: modelData?.notificationId ?? -1
      imageSource: modelData?.image ?? ""
      name: modelData?.name ?? modelData?.appName ?? ""
      favorite: Config.favorites.includes(modelData?.id ?? "") ?? false
      timeElapsed: Functions.timeElapsed(modelData?.time) ?? ""
      description: modelData?.comment ?? modelData?.body ?? ""
      genericName: modelData?.genericName ?? modelData?.summary ??  ""
      categories: modelData?.categories ?? []
      onClicked: root.accept(modelData)
    }
  }
}
