pragma ComponentBehavior: Bound
import QtQuick.Shapes
import Quickshell
import QtQuick.Layouts
// import Quickshell.Widgets
import QtQuick.Controls
import QtQuick
import qs.config
import qs.components
// import qs.services
// import qs.utils
import qs

Item {
  id: root
  required property string monitorId
  required property string searchQuery
  property var sourceModel: []
  property alias list: list
  property alias delegate: list.delegate
  property alias modelData: root.sourceModel
  property bool isOpen: false

  default property alias contents: launcherList.children
  anchors.fill: parent

  Timer {
    id: timer
    interval: Appearance.durations.small
    onTriggered: {
      list.highlightMoveDuration = 0
      list.positionViewAtBeginning()
      list.currentIndex = -1
      list.currentIndex = 0
    }
  }
  Connections {
    target: GlobalState

    function onLauncherOpenChanged() {
      if (GlobalState.launcherOpen && GlobalState.launcherMonitorId === root.monitorId) {
        list.highlightMoveDuration = 100
        root.isOpen = true
      } else {
        root.isOpen = false
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

      Layout.margins: Appearance.spacing.p1
      color: "transparent"

      Rectangle {
        visible: root.sourceModel.length === 0
        anchors.fill: parent
        color: "transparent"
        clip: true
        BorderRectangle {
          id: rect
          color: Appearance.srcery.black
          borderColor: Appearance.srcery.gray3
          borderWidth: Appearance.bar.borderWidth
          anchors.fill: parent
          // anchors.topMargin: root.isOpen ? 0 : Appearance.launcher.height
          //
          // Behavior on anchors.topMargin {
          //   NumberAnimation {
          //     duration: Appearance.durations.normal
          //     easing.type: Easing.InOutCubic
          //   }
          // }
          //
          Triangle {
            id: triangle
            // anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter
            y: root.isOpen ? 25 : Appearance.launcher.height
            width: 170
            height: 150

            Text {
              anchors.centerIn: parent
              anchors.verticalCenterOffset: 22
              font {
                family: Appearance.font.light
                pointSize: Appearance.font.normal
              }
              color: Appearance.srcery.gray4
              // text: "ᛖᛗᛈᛏᛁ"
              text: "EMPTY"
            }
          }
        }
      }
      ListView {
        id: list
        visible: root.sourceModel.length > 0
        anchors.fill: parent
        model: ScriptModel {
          id: model
          values: root.sourceModel
          onValuesChanged: {
            list.currentIndex = -1
            list.currentIndex = 0
            list.positionViewAtBeginning()
          }
        }
        highlightMoveVelocity: 2000
        highlightResizeDuration: 0

        layoutDirection: GlobalState.menuDirection
        spacing: Appearance.spacing.p1
        reuseItems: false
        orientation: ListView.Horizontal
        highlightFollowsCurrentItem: true

        // Horizontall scrolling
        MouseArea {
          anchors.fill: parent
          propagateComposedEvents: true
          acceptedButtons: Qt.NoButton

          onWheel: (wheel) => {
            if (wheel.angleDelta.y !== 0) {
              var delta = wheel.angleDelta.y
              list.flick(delta * 10, 0)
              wheel.accepted = true
            }
          }

          onPressed: (mouse) => { mouse.accepted = false }
        }

        highlight: Item {}
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

        displaced: Transition {
          NumberAnimation {
            property: "x"
            easing.type: Easing.OutCubic
            duration: Appearance.durations.normal
          }
        }
      }
    }
  }
}
