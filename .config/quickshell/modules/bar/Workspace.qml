pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.config
import qs.widgets

Item {
  id: root
  required property int groupOffset
  required property var occupied
  required property int index
  required property int activeWsId
  readonly property real size: childrenRect.height + (occupied ? 7 : 0)
  readonly property bool isOccupied: occupied[ws] ?? false
  readonly property int ws: groupOffset + index + 1
  readonly property bool isWorkspace: true

  Layout.preferredWidth: childrenRect.width
  Layout.preferredHeight: childrenRect.height

  Loader {
    active: !root.isOccupied
    sourceComponent: indicator
  }
  Component {
    id: indicator
    Text {
      // Additional whitespace for proper center alignment
      text: "  "
      color: root.activeWsId === root.ws ? Appearance.srcery.brightWhite : Appearance.srcery.gray6
    }
  }
  RowLayout {
    Repeater {
      model: ScriptModel {
        values: {
          const topLevels = Hyprland.toplevels.values.filter(c => c.workspace?.id === root.ws)
          const classes = Hyprland.toplevels.values
            .filter(c => c.workspace?.id === root.ws)
            .map(c => c.lastIpcObject.class)
            return [...new Set(classes)]
        }
      }

      Icon {
        required property var modelData
        text: {
          return Icons.getAppCategoryIcon(modelData, Icons.defaultIcon)
        } 
      }
    }
  }
}
