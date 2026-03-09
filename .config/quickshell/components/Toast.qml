pragma ComponentBehavior: Bound
import QtQuick.Controls
import Quickshell
import QtQuick
// import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick.Shapes
import QtQuick.VectorImage
import QtQuick.Layouts

import qs.utils
import qs.services
import qs.config
import qs

Item {
  id: root
  required property string monitorId
  anchors.fill: parent

  property int iconSize: 42

  readonly property rect contentRect: Qt.rect(
    columnLayout.x,
    columnLayout.y,
    columnLayout.width,
    columnLayout.height
  )

  visible: Hyprland.focusedMonitor?.name === root.monitorId

  ColumnLayout {
    id: columnLayout
    spacing: Appearance.spacing.p1
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    Behavior on anchors.bottomMargin {
      NumberAnimation {
        duration: Appearance.durations.small
        easing.type: Easing.InOutCubic
      }
    }
    anchors.bottomMargin: {
      let height = Appearance.bar.height + Appearance.spacing.p1
      if (GlobalState.launcherOpen && GlobalState.launcherMonitorId === root.monitorId) {
        height += Appearance.launcher.height
      }
      return height
    }
    // Rectangle {
    //   implicitHeight: Config.notifications.toastHeight
    //   implicitWidth: Config.notifications.toastWidth
    //   color: Appearance.srcery.black
    //   border.width: 1
    //   radius: 5
    //   border.color: Appearance.srcery.gray3
    // }
    Repeater {
      model: Notifications.popupList
      Rectangle {
        implicitHeight: Config.notifications.toastHeight
        id: popup
        implicitWidth: Config.notifications.toastWidth
        color: Appearance.srcery.black
        border.width: Appearance.bar.borderWidth
        radius: 5
        required property var modelData
        border.color: Appearance.srcery.gray3
        ColumnLayout {
          spacing: Appearance.spacing.p2
          anchors.fill: parent
          anchors.margins: Appearance.spacing.p2
          FlexboxLayout {
            gap: Appearance.spacing.p2
            Rectangle {
              implicitWidth: root.iconSize
              implicitHeight: root.iconSize
              border.color: Appearance.srcery.gray3
              color: Appearance.srcery.black
              radius: 4
              Loader {
                anchors.fill: parent
                active: popup.modelData.image !== ""
                sourceComponent: Image {
                  id: image
                  anchors.fill: parent
                  source: popup.modelData.image
                  anchors.margins: Appearance.spacing.p2

                }
              }
            }
            ColumnLayout {
              Layout.fillWidth: true
              spacing: Appearance.spacing.p0
              Text {
                id: name
                elide: Text.ElideRight
                Layout.fillWidth: true
                text: {
                  if (popup.modelData?.appName) {
                    return popup.modelData.appName
                  } else {
                    "(No name)"
                  }
                }
                color: Appearance.srcery.brightWhite
                font {
                  family: Appearance.font.light
                  pointSize: Appearance.font.large
                }
              }
              Text {
                id: summary
                elide: Text.ElideRight
                Layout.fillWidth: true
                text: {
                  if (popup.modelData?.summary) {
                    return popup.modelData.summary
                  }
                  return ""
                }
                color: Appearance.srcery.white
                font {
                  family: Appearance.font.main
                  pointSize: Appearance.font.small
                }
              }
            }

            Button {
              id: closeButton
              states: [
                State {
                  name: "hovered"
                  when: closeMouseArea.containsMouse
                  PropertyChanges { closeRect.border.color: Appearance.srcery.gray6 }
                  PropertyChanges { closeContent.color: Appearance.srcery.white }
                  PropertyChanges { closeMouseArea.cursorShape: Qt.PointingHandCursor }
                }
              ]
              transitions: [
                Transition {
                  ColorAnimation {
                    duration: Appearance.durations.tiny
                    easing.type: Easing.OutQuad
                  }
                }
              ]
              MouseArea {
                id: closeMouseArea
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                  if (popup.modelData?.notificationId) {
                    Notifications.discardNotification(popup.modelData.notificationId)
                  }
                }
              }
              background: Rectangle {
                id: closeRect
                color: Appearance.srcery.black
                border.width: Appearance.bar.borderWidth
                border.color: Appearance.srcery.gray3
                radius: 2
              }
              contentItem: Text {
                id: closeContent
                color: Appearance.srcery.brightBlack
                text: ""
                font {
                  family: Appearance.font.light
                  pixelSize: Appearance.font.normal
                }
              }
            }
          }

          Text {
            color: Appearance.srcery.white
            text: {
              if (popup.modelData?.body) {
                return popup.modelData.body
              } else {
                return ""
              }
            }
            Layout.fillWidth: true
            Layout.fillHeight: true
            elide: Text.ElideRight
            wrapMode: Text.Wrap
            font {
              family: Appearance.font.light
              pointSize: Appearance.font.small
            }
          }
        }
      }
    }
  }
  }
