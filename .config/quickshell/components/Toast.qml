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
      duration: Style.durations.small
      easing.type: Easing.InOutCubic
    }
  }

  Behavior on anchors.rightMargin {
    NumberAnimation {
      duration: Style.durations.small
      easing.type: Easing.InOutCubic
    }
  }

  anchors.bottomMargin: {
    let height = Style.bar.height + Style.spacing.p1
    if (GlobalState.launcherOpen && GlobalState.launcherMonitorId === root.monitorId) {
      height += Style.launcher.height
    }
    return height
  }
  anchors.rightMargin: {
    let margin = Style.spacing.p1
    if (GlobalState.trayMenuOpen) {
      margin += root.menuRect.width + Style.spacing.p1
    }
    return margin
  }
  property int iconSize: 42

  required property rect menuRect

  property int listCount: list?.count ?? 0
  implicitWidth: Style.notifications.toastWidth
  anchors.right: parent.right
  anchors.bottom: parent.bottom
  implicitHeight: (Style.notifications.toastHeight * root.listCount) + (Style.spacing.p0 * root.listCount)
  visible: root.monitorId === Config.primaryDisplay || Config.displays.tv


  ListView {
    verticalLayoutDirection: ListView.BottomToTop
    spacing: Style.spacing.p2
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
      implicitHeight: Style.notifications.toastHeight
      id: popup
      implicitWidth: Style.notifications.toastWidth
      color: Style.srcery.black
      border.width: Style.bar.borderWidth
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
      border.color: Style.srcery.gray3

      MouseArea {
        id: mainArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
          if (popup.notificationId) {
            Notifications.attemptInvokeAction(popup.notificationId, "default");
            // Notifications.discardNotification(popup.notificationId);
          }
        }
      }
      states: [
        State {
          name: "hovered"
          when: mainArea.containsMouse
          PropertyChanges { popup.border.color: Style.srcery.gray5 }
        }
      ]
      transitions: [
        Transition {
          ColorAnimation {
            duration: Style.durations.tiny
            easing.type: Easing.InOutQuad
          }
        }
      ]

      ColumnLayout {
        spacing: Style.spacing.p2
        anchors.fill: parent
        anchors.margins: Style.spacing.p2
        FlexboxLayout {
          gap: Style.spacing.p2
          Rectangle {
            implicitWidth: root.iconSize
            implicitHeight: root.iconSize
            border.color: Style.srcery.gray3
            color: Style.srcery.black
            radius: 4
            Loader {
              anchors.fill: parent
              active: popup.image !== ""
              sourceComponent: Image {
                id: image
                anchors.fill: parent
                source: popup.image
                anchors.margins: Style.spacing.p2

              }
            }
            Loader {
              anchors.fill: parent
              active: popup.appIcon !== ""
              sourceComponent: IconImage {
                id: icon
                anchors.fill: parent
                source: Quickshell.iconPath(popup.appIcon)
                anchors.margins: Style.spacing.p2

              }
            }
          }
          ColumnLayout {
            Layout.fillWidth: true
            spacing: Style.spacing.p0
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
              color: Style.srcery.brightWhite
              font {
                family: Style.font.light
                pointSize: Style.font.large
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
              color: Style.srcery.white
              font {
                family: Style.font.main
                pointSize: Style.font.small
              }
            }
          }

          Button {
            id: closeButton
            states: [
              State {
                name: "hovered"
                when: closeMouseArea.containsMouse
                PropertyChanges { closeRect.border.color: Style.srcery.gray6 }
                PropertyChanges { closeContent.color: Style.srcery.white }
              }
            ]
            transitions: [
              Transition {
                ColorAnimation {
                  duration: Style.durations.tiny
                  easing.type: Easing.OutQuad
                }
              }
            ]
            MouseArea {
              id: closeMouseArea
              anchors.fill: parent
              hoverEnabled: true
              cursorShape: Qt.PointingHandCursor

              onClicked: {
                if (popup.notificationId) {
                  Notifications.discardNotification(popup.notificationId)
                }
              }
            }
            background: Rectangle {
              id: closeRect
              color: Style.srcery.black
              border.width: Style.bar.borderWidth
              border.color: Style.srcery.gray3
              radius: 2
            }
            contentItem: Text {
              id: closeContent
              color: Style.srcery.brightBlack
              text: ""
              font {
                family: Style.font.light
                pixelSize: Style.font.normal
              }
            }
          }
        }

        Text {
          color: Style.srcery.white
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
            family: Style.font.light
            pointSize: Style.font.small
          }
        }
      }
    }
    remove: Transition {
      ParallelAnimation {
        NumberAnimation {
          property: "x"
          to: Style.notifications.toastWidth
          easing.type: Easing.InCubic
          duration: Style.durations.normal
        }
        NumberAnimation {
          property: "opacity"
          to: 0
          easing.type: Easing.InQuad
          duration: Style.durations.normal
        }
      }
    }
    add: Transition {
      NumberAnimation {
        property: "opacity"
        from: 0; to: 1
        duration: Style.durations.normal
      }
      NumberAnimation {
        properties: "x,y"
        easing.type: Easing.OutCubic
        duration: Style.durations.normal
      }
    }
    displaced: Transition {
      NumberAnimation {
        properties: "x,y"
        easing.type: Easing.OutCubic
        duration: Style.durations.normal
      }
    }
  }

}
