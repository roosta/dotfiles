pragma ComponentBehavior: Bound
import QtQuick.Controls
import Quickshell.Widgets
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
  // anchors.fill: parent

  Behavior on anchors.bottomMargin {
    NumberAnimation {
      duration: Appearance.durations.small
      easing.type: Easing.InOutCubic
    }
  }

  Behavior on anchors.rightMargin {
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
  anchors.rightMargin: {
    let margin = Appearance.spacing.p1
    if (GlobalState.trayMenuOpen) {
      margin += root.menuRect.width + Appearance.spacing.p1
    }
    return margin
  }
  property int iconSize: 42

  required property rect menuRect

  property int listCount: list?.count ?? 0
  implicitWidth: Appearance.notifications.toastWidth
  anchors.right: parent.right
  anchors.bottom: parent.bottom
  implicitHeight: (Appearance.notifications.toastHeight * root.listCount) + (Appearance.spacing.p0 * root.listCount)
  visible: root.monitorId === Config.primaryDisplay


  ListView {
    verticalLayoutDirection: ListView.BottomToTop
    spacing: Appearance.spacing.p2
    anchors.fill: parent
    id: list
    model: ScriptModel {
      values: Notifications.popupList

      // values:  [
      //   {
      //     "notificationId": 21,
      //     "actions": [],
      //     "appIcon": "",
      //     "appName": "notify-send",
      //     "body": "This is a test that is long and will take up a fair bit of space so we can check padding. Needs to be a bit longer, we need to reach the content edge",
      //     "image": "image://icon//home/roosta/Dropbox/avatars/fif.png",
      //     "summary": "Foo Bar Baz Fiz Bang Long Line Huzza Truncate This Please",
      //     "time": 1773145284617,
      //     "urgency": "1"
      //   },
      //   {
      //     "notificationId": 21,
      //     "actions": [],
      //     "appIcon": "",
      //     "appName": "notify-send",
      //     "body": "This is a test that is long and will take up a fair bit of space so we can check padding. Needs to be a bit longer, we need to reach the content edge",
      //     "image": "image://icon//home/roosta/Dropbox/avatars/fif.png",
      //     "summary": "Foo Bar Baz Fiz Bang Long Line Huzza Truncate This Please",
      //     "time": 1773145284617,
      //     "urgency": "1"
      //   }
      // ]

    }

    delegate: Rectangle {
      implicitHeight: Appearance.notifications.toastHeight
      id: popup
      implicitWidth: Appearance.notifications.toastWidth
      color: Appearance.srcery.black
      border.width: Appearance.bar.borderWidth
      // radius: 5
      required property var modelData
      border.color: Appearance.srcery.gray3

      MouseArea {
        id: mainArea
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
          if (popup.modelData?.notificationId) {

            // Notifications.attemptInvokeAction(popup.modelData.notificationId, modelData.identifier);
            // Notifications.discardNotification(popup.modelData?.notificationId);
          }
        }
      }
      states: [
        State {
          name: "hovered"
          when: mainArea.containsMouse
          PropertyChanges { popup.border.color: Appearance.srcery.gray5 }
          PropertyChanges { closeMouseArea.cursorShape: Qt.PointingHandCursor }
        }
      ]
      transitions: [
        Transition {
          ColorAnimation {
            duration: Appearance.durations.tiny
            easing.type: Easing.InOutQuad
          }
        }
      ]

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
            Loader {
              anchors.fill: parent
              active: popup.modelData.appIcon !== ""
              sourceComponent: IconImage {
                id: icon
                anchors.fill: parent
                source: Quickshell.iconPath(popup.modelData.appIcon)
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
    remove: Transition {
      NumberAnimation {
        properties: "x,y"
        easing.type: Easing.OutCubic
        duration: Appearance.durations.normal
      }
    }
    add: Transition {
      NumberAnimation {
        properties: "x,y"
        easing.type: Easing.OutCubic
        duration: Appearance.durations.normal
      }
    }
    displaced: Transition {
      NumberAnimation {
        properties: "x,y"
        easing.type: Easing.OutCubic
        duration: Appearance.durations.normal
      }
    }
  }

}
