pragma ComponentBehavior: Bound
import Quickshell
import QtQuick.Layouts
import Quickshell.Widgets
import QtQuick.Controls
import QtQuick
import qs.config
import qs.components
import qs.services
// import qs.utils
import qs

Item {
  id: root
  required property string monitorId
  required property string searchQuery
  property alias list: list
  anchors.fill: parent

  Connections {
    target: GlobalState

    function onLauncherOpenChanged() {
      if (GlobalState.launcherOpen && GlobalState.activeMonitorId === root.monitorId) {
        list.highlightMoveDuration = 1000
      } else {
        list.highlightMoveDuration = 0
        list.positionViewAtBeginning()
        list.currentIndex = 0
      }
    }
  }

  Rectangle {
    id: audioList
    anchors.fill: parent
    anchors.margins: Appearance.spacing.p4 + Appearance.bar.borderWidth
    color: "transparent"
    clip: true

    ListView {
      id: list
      anchors.fill: parent
      reuseItems: true
      highlightFollowsCurrentItem: true
      delegate: Item { 
        Text {
          text: "hello world"
        }
      }
      highlight: Rectangle {
        color: "transparent"
        z: 2
        border.color: Appearance.srcery.gray3
        border.width: Appearance.bar.borderWidth
      }
      model: ScriptModel {
        id: listData
        onValuesChanged: {
          list.currentIndex = 0
          list.positionViewAtBeginning()
        }
        values: ["hello", "world"]
      }

      ScrollBar.vertical: ScrollBar {
        id: scroll
        padding: 0
        implicitWidth: Appearance.spacing.p1
        contentItem: BorderRectangle {
          anchors.left: parent.left
          anchors.right: parent.right
          borderWidth: 1
          color: Appearance.srcery.black
          borderColor: Appearance.srcery.gray3

          MouseArea {
            id: mouse

            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            hoverEnabled: true
            acceptedButtons: Qt.NoButton
          }
        }
      }
    }
  }
}
