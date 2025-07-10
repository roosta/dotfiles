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

  Layout.preferredWidth: childrenRect.width
  Layout.preferredHeight: childrenRect.height

  Text {
    id: indicator

    // Additional whitespace for proper center alignment
    readonly property string label: "  "

    text: label
    color: root.activeWsId === root.ws ? Appearance.srcery.brightWhite : Appearance.srcery.gray6
  }
  Repeater {
    model: ScriptModel {
      values: Hyprland.toplevels.values.filter(c => c.workspace?.id === root.ws)
      onValuesChanged: {
        values.forEach((toplevel, index) => {
          // console.log(toplevel)
        })
      }
    }

    // Icon {
    //   required property var modelData
    //   className: modelData.lastIpcObject.class
    //   onModelDataChanged: {
    //     console.log(modelData.lastIpcObject)
    //   }
    // }
  }
}
