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
import QtQuick.Effects
import qs.utils

Item {
  id: root
  required property string monitorId
  property var sourceModel: []
  property alias list: list
  property alias delegate: list.delegate
  property alias modelData: root.sourceModel
  property bool isOpen: false

  default property alias contents: launcherList.children

  Layout.fillWidth: true
  Layout.fillHeight: true

  clip: true
  Layout.topMargin: Style.bar.borderWidth
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
        id: emptyContainer
        visible: false
        anchors.fill: parent
        color: Style.srcery.black
        clip: true
        Connections {
          target: root
          function onSourceModelChanged() {
            if (root.sourceModel.length === 0) {
              if (emptyTimer.running) {
                emptyTimer.stop()
              }
              if (!emptyContainer.visible) {
                emptyContainer.visible = true
              }
            } else if (emptyContainer.visible && !emptyTimer.running) {
              emptyTimer.restart()
            }
          }
        }
        BorderRect {
          id: border
          color: "transparent"
          borderColor: root.sourceModel.length === 0 ? Style.srcery.gray3 : Style.srcery.black
          borderWidth: Style.bar.borderWidth
          anchors.fill: parent

          Quad {
            width: 50
            height: 50
            anchors.topMargin: Style.spacing.p2
            fillColor: "transparent"
            strokeColor: root.sourceModel.length === 0 ? Style.srcery.gray3 : Style.srcery.black
            anchors.leftMargin: Style.spacing.p2
            anchors.top: parent.top
            anchors.left: parent.left
            topLeft:  Qt.point(1, 0)
            topRight: Qt.point(1, 0)
            rotation: 180
            Behavior on strokeColor {
              ColorAnimation {
                duration: Style.durations.normal
                easing.type: Easing.InOutQuad
              }
            }
          }

          Quad {
            width: 50
            height: 50
            fillColor: "transparent"
            strokeColor: root.sourceModel.length === 0 ? Style.srcery.gray3 : Style.srcery.black
            anchors.topMargin: Style.spacing.p2
            anchors.rightMargin: Style.spacing.p2
            anchors.top: parent.top
            anchors.right: parent.right
            topLeft:  Qt.point(1, 0)
            topRight: Qt.point(1, 0)
            rotation: -90
            Behavior on strokeColor {
              ColorAnimation {
                duration: Style.durations.normal
                easing.type: Easing.InOutQuad
              }
            }
          }
          Timer {
            id: emptyTimer
            interval: Style.animationCurves.expressiveSlowSpatialDuration
            onTriggered: {
              emptyContainer.visible = false
            }
          }
          Behavior on borderColor {
            ColorAnimation {
              duration: Style.durations.normal
              easing.type: Easing.InOutQuad
            }
          }

          MultiEffect {
            source: emptyItem
            anchors.fill: emptyItem
            shadowBlur: 1.0
            shadowEnabled: true
            shadowColor: Functions.transparentize("#000", 0.5)
            shadowVerticalOffset: 0
            shadowHorizontalOffset: 0
          }

          Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: size
            height: size
            id: emptyItem
            y: {
              if (root.sourceModel.length === 0) {
                return (Style.launcher.height - emptyItem.size - Style.spacing.p1 * 2) / 2
              } else {
                return Style.launcher.height
              }
            }

            Behavior on y {
              NumberAnimation {
                duration: Style.animationCurves.expressiveSlowSpatialDuration
                easing.type: Easing.BezierSpline
                easing.bezierCurve: Style.animationCurves.expressiveSlowSpatial
              }
            }
            property int size: 150
            Rectangle {
              id: outerRect
              border.color: Style.srcery.gray3
              anchors.fill: parent
              Text {
                rotation: -45
                anchors.leftMargin: Style.spacing.p3
                anchors.topMargin: Style.spacing.p3
                anchors.top: parent.top
                anchors.left: parent.left
                font {
                  family: Style.font.light
                  pointSize: 16
                }
                color: Style.srcery.gray4
                text: ""
              }
              Behavior on rotation {
                NumberAnimation {
                  duration: Style.animationCurves.expressiveSlowSpatialDuration
                  easing.type: Easing.BezierSpline
                  easing.bezierCurve: Style.animationCurves.expressiveSlowSpatial
                }
              }
              rotation: {
                if (root.sourceModel.length === 0) {
                  return 45
                } else {
                  return 0
                }
              }
              border.width: Style.bar.borderWidth
              color: Style.srcery.black
              Rectangle {
                color: "transparent"
                border.color: Style.srcery.gray3
                border.width: Style.bar.borderWidth
                id: innerRect
                rotation: -45
                width: {
                  return emptyItem.size / Math.sqrt(2)
                }
                height: width
                anchors.centerIn: parent
                Rectangle {
                  anchors.fill: parent
                  radius: parent.width / 2
                  color: "transparent"
                  border.color: Style.srcery.gray3
                  border.width: 1
                }
              }

            }
            Text {
              anchors.centerIn: parent
              width: innerRect.width - Style.spacing.p2 * 2
              horizontalAlignment: Text.AlignHCenter
              font {
                family: Style.font.light
                pointSize: Style.font.normal
              }

              wrapMode: Text.Wrap
              color: Style.srcery.gray4
              text: `NO ${GlobalState.launcherMode.toUpperCase()}`
            }
          }
        }
      }
      ListView {
        id: list
        visible: count > 0
        // clip: true
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
              easing.bezierCurve: Style.animationCurves.expressiveFastSpatial
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
        populate: Transition {
          NumberAnimation {
            properties: "opacity"
            to: 1.0
            easing.type: Easing.Linear
            duration: Style.durations.tiny
          }
          NumberAnimation {
            properties: "x"
            duration: Style.animationCurves.expressiveDefaultSpatialDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Style.animationCurves.expressiveDefaultSpatial
          }
        }

        add: Transition {
          NumberAnimation {
            properties: "opacity"
            to: 1.0
            easing.type: Easing.Linear
            duration: Style.durations.tiny
          }
          NumberAnimation {
            properties: "y"
            from: -Style.launcher.height
            to: 0
            duration: Style.animationCurves
            .expressiveFastSpatialDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Style.animationCurves
            .expressiveFastSpatial
          }
          // NumberAnimation {
          //   property: "opacity"
          //   to: 1.0
          // }
        }

        remove: Transition {
          NumberAnimation {
            properties: "opacity"
            to: 0.0
            easing.type: Easing.Linear
            duration: Style.durations.tiny
          }
          NumberAnimation {
            properties: "y"
            to: Style.launcher.height
            duration: Style.animationCurves
              .expressiveFastSpatialDuration
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Style.animationCurves
              .expressiveFastSpatial
          }
        }

        displaced: Transition {
          NumberAnimation {
            property: "opacity"
            to: 1.0
          }
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
        move: Transition {
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
