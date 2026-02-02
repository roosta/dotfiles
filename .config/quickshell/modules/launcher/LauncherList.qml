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
  property alias model: list.model
  property alias list: list
  property alias delegate: list.delegate

  default property alias contents: launcherList.children
  anchors.fill: parent

  onModelChanged: {
    list.currentIndex = 0
    list.positionViewAtBeginning()
  }

  Timer {
    id: timer
    interval: Appearance.durations.small
    onTriggered: {
      list.highlightMoveDuration = 0
      list.positionViewAtBeginning()
      list.currentIndex = 0
    }
  }
  Connections {
    target: GlobalState

    function onLauncherOpenChanged() {
      if (GlobalState.launcherOpen && GlobalState.launcherMonitorId === root.monitorId) {
        list.highlightMoveDuration = 100
      } else {
        timer.restart()
      }
    }
  }

  ColumnLayout {
    id: launcherList
    anchors.fill: parent
    spacing: 0
    Rectangle {
      Layout.fillWidth: true
      Layout.fillHeight: true

      Layout.margins: Appearance.spacing.p1 + Appearance.bar.borderWidth
      color: "transparent"
      clip: true

      ListView {
        id: list
        anchors.fill: parent
        highlightMoveVelocity: 2000
        highlightResizeDuration: 0
        spacing: Appearance.spacing.p1
        reuseItems: true
        orientation: ListView.Horizontal
        highlightFollowsCurrentItem: true
        highlight: Rectangle {
          color: Appearance.srcery.gray1
          // z: 2
          // border.color: Appearance.srcery.gray4
          // border.width: Appearance.bar.borderWidth
        }
        ScrollBar.horizontal: ScrollBar {
          id: scroll
          padding: 0
          // implicitWidth: Appearance.spacing.p1
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

        // add: Transition {
        //   NumberAnimation {
        //     properties: "opacity,scale"
        //     easing.type: Easing.InCubic
        //     duration: Appearance.durations.normal
        //     from: 0
        //     to: 1
        //   }
        // }
        //
        // move: Transition {
        //   NumberAnimation {
        //     properties: "y"
        //     easing.type: Easing.InOutCubic
        //     duration: Appearance.durations.normal
        //   }
        //
        //   NumberAnimation {
        //     properties: "opacity,scale"
        //     easing.type: Easing.InOutCubic
        //     duration: Appearance.durations.normal
        //     to: 1
        //   }
        // }
        // remove: Transition {
        //   NumberAnimation {
        //     properties: "opacity,scale"
        //     easing.type: Easing.OutCubic
        //     duration: Appearance.durations.normal
        //     from: 0
        //     to: 1
        //   }
        // }
        //
        // addDisplaced: Transition {
        //   NumberAnimation {
        //     property: "y"
        //     easing.type: Easing.InOutCubic
        //     duration: Appearance.durations.small
        //   }
        //   NumberAnimation {
        //     properties: "opacity,scale"
        //     to: 1
        //     easing.type: Easing.InOutCubic
        //     duration: Appearance.durations.normal
        //   }
        // }
        //
        // displaced: Transition {
        //   NumberAnimation {
        //     property: "y"
        //     easing.type: Easing.InOutCubic
        //     duration: Appearance.durations.normal
        //   }
        //   NumberAnimation {
        //     properties: "opacity,scale"
        //     to: 1
        //
        //     easing.type: Easing.InOutCubic
        //     duration: Appearance.durations.normal
        //   }
        // }
      }
    }
  }
}
