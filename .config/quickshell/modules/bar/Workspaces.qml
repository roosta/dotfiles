import QtQuick
import Quickshell
import QtQuick.Layouts
import qs.services 
import qs.config
pragma ComponentBehavior: Bound

Rectangle {
  id: root
  color: Appearance.srcery.gray2
  required property int show
  required property ShellScreen screen
  readonly property list<Workspace> workspaces: layout.children.filter(c => c.isWorkspace).sort((w1, w2) => w1.ws - w2.ws)
  readonly property var occupied: Hyprland.workspaces.values.reduce((acc, curr) => {
    acc[curr.id] = curr.lastIpcObject.windows > 0;
    return acc;
  }, {})
  readonly property int groupOffset: Math.floor((Hyprland.activeWsId - 1) / show) * show
  readonly property int activeWsId: Hyprland.monitorFor(screen).activeWorkspace?.id ?? 1
  readonly property bool isWorkspace: true

  implicitWidth: layout.implicitWidth + Appearance.spacing.p2
  Layout.fillHeight: true

  radius: 10
  Item {
    id: inner

    anchors.fill: parent
    RowLayout {
      id: layout
      spacing: 5
      anchors.centerIn: parent
      Repeater {
        model: root.show

        Workspace {
          occupied: root.occupied
          groupOffset: root.groupOffset
          activeWsId: root.activeWsId
        }
      }
    }
    MouseArea {
      anchors.fill: parent
      onPressed: event => {
        const ws = layout.childAt(event.x, event.y).index + root.groupOffset + 1;
        if (Hyprland.activeWsId !== ws) {
          Hyprland.dispatch(`workspace ${ws}`);
        }
      }
    }
  }
}
