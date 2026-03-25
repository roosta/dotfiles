// ┌───────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░░▀█▀░█▀█░█▀█░█▀▀░▀█▀░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░░░█░░█░█░█▀█░▀▀█░░█░░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░░░▀░░▀▀▀░▀░▀░▀▀▀░░▀░░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀───────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>      ├┤
// ││ Repo    : https://github.com/roosta/dotfiles││
// ││ Site    : https://www.roosta.sh             ││
// ├┤ License : GNU General Public License v3     ├┤
// ┆└─────────────────────────────────────────────┘┆

pragma ComponentBehavior: Bound
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell
import QtQuick
// import Quickshell.Wayland
// import Quickshell.Hyprland
// import Quickshell.Wayland
// import QtQuick.Shapes
// import QtQuick.VectorImage
import QtQuick.Layouts

// import qs.utils
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
  visible: root.monitorId === Config.primaryDisplay || Config.displays.tv


  ListView {
    verticalLayoutDirection: ListView.BottomToTop
    spacing: Appearance.spacing.p2
    anchors.fill: parent
    id: list
    model: ListModel { id: toastModel }

    function syncModel(newList) {
      for (let i = toastModel.count - 1; i >= 0; i--) {
        let found = newList
          .some(n => n.notificationId === toastModel.get(i).notificationId)
        if (!found) toastModel.remove(i)
      }
      for (let item of newList) {
        let found = false
        for (let i = 0; i < toastModel.count; i++) {
          if (toastModel.get(i).notificationId === item.notificationId) {
            found = true;
            break
          }
        }
        if (!found) toastModel.append(item)
      }
    }

    Connections {
      target: Notifications
      function onPopupListChanged() {
        list.syncModel(Notifications.popupList)
      }
    }

    Component.onCompleted: list.syncModel(Notifications.popupList)

    delegate: Rectangle {
      implicitHeight: Appearance.notifications.toastHeight
      id: popup
      implicitWidth: Appearance.notifications.toastWidth
      color: Appearance.srcery.black
      border.width: Appearance.bar.borderWidth
      // radius: 5
      required property int index
      required property var notificationId
      required property string appName
      required property string summary
      required property string body
      required property string image
      required property string appIcon
      required property var actions
      required property string urgency
      required property var time
      border.color: Appearance.srcery.gray3

      MouseArea {
        id: mainArea
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
          if (popup.notificationId) {

            // Notifications.attemptInvokeAction(popup.notificationId, modelData.identifier);
            // Notifications.discardNotification(popup.notificationId);
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
              active: popup.image !== ""
              sourceComponent: Image {
                id: image
                anchors.fill: parent
                source: popup.image
                anchors.margins: Appearance.spacing.p2

              }
            }
            Loader {
              anchors.fill: parent
              active: popup.appIcon !== ""
              sourceComponent: IconImage {
                id: icon
                anchors.fill: parent
                source: Quickshell.iconPath(popup.appIcon)
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
                if (popup.appName) {
                  return popup.appName
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
                if (popup.summary) {
                  return popup.summary
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
                if (popup.notificationId) {
                  Notifications.discardNotification(popup.notificationId)
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
            if (popup.body) {
              return popup.body
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
      ParallelAnimation {
        NumberAnimation {
          property: "x"
          to: Appearance.notifications.toastWidth
          easing.type: Easing.InCubic
          duration: Appearance.durations.normal
        }
        NumberAnimation {
          property: "opacity"
          to: 0
          easing.type: Easing.InQuad
          duration: Appearance.durations.normal
        }
      }
    }
    add: Transition {
      NumberAnimation {
        property: "opacity"
        from: 0; to: 1
        duration: Appearance.durations.normal
      }
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
