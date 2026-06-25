// ┌────────────────────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█░░░█▀█░█░█░█▀█░█▀▀░█░█░█▀▀░█▀▄░█░░░▀█▀░█▀▀░▀█▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█░░░█▀█░█░█░█░█░█░░░█▀█░█▀▀░█▀▄░█░░░░█░░▀▀█░░█░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░░▀░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>                               ├┤
// ││ Repo    : https://github.com/roosta/dotfiles                         ││
// ││ Site    : https://www.roosta.sh                                      ││
// ├┤ License : GNU General Public License v3                              ├┤
// ┆└──────────────────────────────────────────────────────────────────────┘┆

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
  property var sourceModel: []
  property alias list: list
  property alias delegate: list.delegate
  property alias modelData: root.sourceModel
  property bool isOpen: false

  default property alias contents: launcherList.children
  anchors.fill: parent

  Timer {
    id: timer
    interval: Style.durations.small
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
      if (GlobalState.launcherMonitorId === root.monitorId) {
        if (GlobalState.launcherOpen) {
          list.highlightMoveDuration = 100
          root.isOpen = true
          if (GlobalState.menuIndex > 0) {
            list.currentIndex = GlobalState.menuIndex
          }
        } else {
          root.isOpen = false
          timer.restart()
        }
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

      Layout.margins: Style.spacing.p1
      color: "transparent"

      Rectangle {
        visible: root.sourceModel.length === 0
        anchors.fill: parent
        color: "transparent"
        clip: true
        BorderRect {
          id: rect
          color: Style.srcery.black
          borderColor: Style.srcery.gray3
          borderWidth: Style.bar.borderWidth
          anchors.fill: parent
          // anchors.topMargin: root.isOpen ? 0 : Style.launcher.height
          //
          // Behavior on anchors.topMargin {
          //   NumberAnimation {
          //     duration: Style.durations.normal
          //     easing.type: Easing.InOutCubic
          //   }
          // }
          //
          Triangle {
            id: triangle
            anchors.horizontalCenter: parent.horizontalCenter
            y: root.isOpen ? 25 : Style.launcher.height
            width: 170
            height: 150

            Text {
              anchors.centerIn: parent
              anchors.verticalCenterOffset: 22
              font {
                family: Style.font.light
                pointSize: Style.font.normal
              }
              color: Style.srcery.gray4
              // text: "ᛖᛗᛈᛏᛁ"
              text: "EMPTY"
            }
          }
        }
      }
      ListView {
        id: list
        visible: root.sourceModel.length > 0
        clip: true
        anchors.fill: parent
        // currentIndex: GlobalState.menuIndex

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
        spacing: Style.spacing.p1
        reuseItems: false
        orientation: ListView.Horizontal

        // Horizontall scrolling
        WheelHandler {
          acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
          grabPermissions: PointerHandler.CanTakeOverFromAnything
          onWheel: (event) => {
            const delta = event.angleDelta.y !== 0
            ? event.angleDelta.y
            : event.angleDelta.x
            list.contentX = Math.max(0, Math.min(
              list.contentWidth - list.width,
              list.contentX - delta
            ))
          }
        }
        focus: true

        highlightFollowsCurrentItem: true
        highlight: GradientRect {
          gradientAngle: 45
          z: 99

          x: list.currentItem?.x ?? 0
          implicitWidth: list.currentItem?.implicitWidth ?? 0
          implicitHeight: list.height
          Behavior on x {
            NumberAnimation {
              duration: Style.animationCurves.expressiveFastSpatialDuration
              easing.type: Easing.BezierSpline
              easing.bezierCurve: Style.animationCurves.expressiveDefaultSpatial
            }
          }
          gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 1; color: Style.srcery.magenta }
            GradientStop { position: 0; color: Style.srcery.blue }
          }
          // anchors.fill: parent
        }
        ScrollBar.horizontal: ScrollBar {
          id: scroll
          padding: 0
          // implicitWidth: Style.spacing.p1
          contentItem: BorderRect {
            anchors.left: parent.left
            anchors.right: parent.right
            borderWidth: 1
            color: Style.srcery.black
            borderColor: Style.srcery.gray3

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
          NumberAnimation {
            properties: "opacity"
            from: 0
            to: 1
            duration: Style.durations.medium
          }
        }
        remove: Transition {
          NumberAnimation {
            properties: "opacity"
            to: 0
            duration: Style.durations.medium
          }
        }
        displaced: Transition {
          NumberAnimation { property: "opacity"; to: 1.0 }
          // NumberAnimation { property: "scale"; to: 1.0 }
          NumberAnimation {
            properties: "x"
            duration: Style.animationCurves
              .expressiveDefaultSpatialDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Style.animationCurves
              .expressiveDefaultSpatial
          }
        }
      }
    }
  }
}
