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
  property var sourceModel: []
  property alias modelData: root.sourceModel
  property alias list: list
  property alias delegate: list.delegate

  default property alias contents: launcherList.children
  anchors.fill: parent

  ListModel {
    id: dynamicModel

    function getId(item) {
      return item?.id ?? item?.name ?? JSON.stringify(item)
    }

    function updateModel() {
      const newData = root.sourceModel
      const newIds = newData.map(getId)
      const oldIds = []

      // Build old IDs list
      for (let i = 0; i < dynamicModel.count; i++) {
        oldIds.push(getId(dynamicModel.get(i).modelData))
      }

      // Remove items that no longer exist
      for (let i = dynamicModel.count - 1; i >= 0; i--) {
        const id = getId(dynamicModel.get(i).modelData)
        if (!newIds.includes(id)) {
          dynamicModel.remove(i)
        }
      }

      // Add new items and move existing ones
      for (let i = 0; i < newData.length; i++) {
        const item = newData[i]
        const id = getId(item)

        // Find current position
        let currentIndex = -1
        for (let j = 0; j < dynamicModel.count; j++) {
          if (getId(dynamicModel.get(j).modelData) === id) {
            currentIndex = j
            break
          }
        }

        if (currentIndex === -1) {
          // New item - insert
          dynamicModel.insert(i, { modelData: item })
        } else if (currentIndex !== i) {
          // Existing item in wrong position - move
          dynamicModel.move(currentIndex, i, 1)
        }
      }
    }
  }

  onSourceModelChanged: {
    dynamicModel.updateModel()
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

      Layout.margins: Appearance.spacing.p1
      color: "transparent"
      clip: true

      ListView {
        id: list
        anchors.fill: parent
        model: dynamicModel
        highlightMoveVelocity: 2000
        highlightResizeDuration: 0
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
              list.flick(delta * 30, 0)
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

        add: Transition {
          SequentialAnimation {
            PauseAnimation {
              duration: {
                if (ViewTransition.index > 0) {
                  return ViewTransition.index * 30
                } else {
                  return 100
                }
              }
            }
            ParallelAnimation {
              NumberAnimation {
                property: "x"
                easing.type: Easing.OutCubic
                duration: Appearance.durations.normal
              }
              NumberAnimation {
                property: "opacity"
                easing.type: Easing.OutCubic
                duration: Appearance.durations.normal
                from: 0
                to: 1
              }
            }
          }
        }

        move: Transition {
          NumberAnimation {
            property: "x"
            easing.type: Easing.InOutCubic
            duration: Appearance.durations.normal
          }
        }

        remove: Transition {
          SequentialAnimation {
            PropertyAction { property: "ListView.delayRemove"; value: true }
            ParallelAnimation {
              NumberAnimation {
                property: "opacity"
                easing.type: Easing.InCubic
                duration: Appearance.durations.small
                to: 0
              }
              // NumberAnimation {
              //   property: "scale"
              //   easing.type: Easing.InCubic
              //   duration: Appearance.durations.small
              //   to: 0.8
              // }
            }
            PropertyAction { property: "ListView.delayRemove"; value: false }
          }
        }

        addDisplaced: Transition {
          NumberAnimation {
            property: "x"
            easing.type: Easing.OutCubic
            duration: Appearance.durations.normal
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
