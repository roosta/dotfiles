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
      iconSource: modelData.iconId
        ? Quickshell.iconPath(modelData.iconId)
        : Icons.getEntryIcon(modelData)
      name: modelData?.name
      favorite: Config.favorites.includes(modelData?.id ?? "") ?? false
      description: modelData?.comment ?? ""
      genericName: modelData?.genericName ?? ""
      categories: modelData?.categories ?? []
      onClicked: root.accept(modelData)
    }
  }
}
