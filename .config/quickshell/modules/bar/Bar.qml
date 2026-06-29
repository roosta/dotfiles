// ┌───────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░░░░░░█▀▄░█▀█░█▀▄░░░░░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░░░░░░█▀▄░█▀█░█▀▄░░░░░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░░░░░░▀▀░░▀░▀░▀░▀░░░░░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀───────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>      ├┤
// ││ Repo    : https://github.com/roosta/dotfiles││
// ││ Site    : https://www.roosta.sh             ││
// ├┤ License : GNU General Public License v3     ├┤
// ┆└─────────────────────────────────────────────┘┆

import QtQuick
import qs.components
import qs.services
import QtQuick.Controls
import QtQuick.Layouts
import qs.config
pragma ComponentBehavior: Bound

Item {
  id: root
  required property string monitorId

  z: 1
  implicitHeight: Style.bar.height

  signal decrementCurrentIndex()
  signal incrementCurrentIndex()
  signal accepted()

  anchors {
    bottom: parent.bottom
    left: parent.left
    right: parent.right
  }

  BorderRect {
    id: barContent
    color: Style.srcery.black
    borderColor: Style.srcery.gray3
    topBorder: 1
    anchors {
      right: parent.right
      left: parent.left
      top: parent.top
      bottom: parent.bottom
    }
    Rectangle {
      anchors.fill: parent
      color: "transparent"

      Loader {
        id: barLoader
        anchors.fill: parent
        sourceComponent: {
          if (root.monitorId === Config.displays?.left) {
            return leftBar
          } else if (root.monitorId === Config.displays?.right){
            return rightBar
          } else if (root.monitorId === Config.displays?.top){
            return topBar
          } else {
            return primaryBar
          }
        }
      }}
    }
    Component {
      id: primaryBar
      Rectangle {
        color: "transparent"
        anchors.fill: parent

        RowLayout {
          anchors.fill: parent
          spacing: 0
          Rectangle {
            id: leftSection
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"
            RowLayout {
              spacing: Style.spacing.p1
              anchors.left: parent.left
              anchors.fill: parent
              LauncherButton {
                monitorId: root.monitorId
                onDecrementCurrentIndex: root.decrementCurrentIndex()
                onIncrementCurrentIndex: root.incrementCurrentIndex()
                onAccepted: root.accepted()
              }
              Separator {}
              Loader {
                Layout.fillHeight: true
                Layout.fillWidth: true
                active: LauncherData.appsData.length > 0
                sourceComponent: Context { }
              }

            }
          }
          Rectangle {
            id: centerSection
            color: "transparent"
            Layout.fillHeight: true
            Layout.fillWidth: true
            // Layout.alignment: Qt.AlignHCenter
            RowLayout {
              spacing: Style.spacing.p1
              anchors.centerIn: parent
              WsButton { direction: -1; monitorId: root.monitorId }
              Workspaces { monitorId: root.monitorId }
              WsButton { direction: 1; monitorId: root.monitorId }
            }
          }
          Rectangle {
            id: rightSection
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "transparent"
            RowLayout {
              spacing: Style.spacing.p1
              anchors.right: parent.right
              // anchors.rightMargin: Style.spacing.p1
              // anchors.fill: parent
              Clock { }
              Separator {}
              AlertsIndicator { monitorId: root.monitorId }
              KeyboardButton { monitorId: root.monitorId }
              AudioButton { monitorId: root.monitorId }
              TrayButton { monitorId: root.monitorId }
              NotificationButton { monitorId: root.monitorId }
            }
          }
        }
      }
    }

    Component {
      id: rightBar
      Rectangle {
        color: "transparent"

        RowLayout {
          anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
            right: parent.right
          }
          RowLayout {
            id: leftSection
            spacing: Style.spacing.p1
            Layout.leftMargin: Style.spacing.p1

            LauncherButton {
              monitorId: root.monitorId
              onDecrementCurrentIndex: root.decrementCurrentIndex()
              onIncrementCurrentIndex: root.incrementCurrentIndex()
              onAccepted: root.accepted()
            }

            Workspaces {
              monitorId: root.monitorId
            }

          }
          RowLayout {
            id: centerSection
            spacing: Style.spacing.p1

          }
          RowLayout {
            id: rightSection
          }
        }
      }
    }
    Component {
      id: leftBar
      Rectangle {
        color: "transparent"

        RowLayout {
          anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
            right: parent.right
          }
          RowLayout {
            id: leftSection
            Layout.fillWidth: true
            Layout.fillHeight: true
            // ActiveWindow { }
          }
          RowLayout {
            id: centerSection
            spacing: Style.spacing.p1

            // NotificationButton {}
          }
          RowLayout {
            id: rightSection
            spacing: Style.spacing.p1
            // Layout.rightMargin: Style.spacing.p1
            Workspaces {
              monitorId: root.monitorId
            }
            LauncherButton {
              monitorId: root.monitorId
              onDecrementCurrentIndex: root.decrementCurrentIndex()
              onIncrementCurrentIndex: root.incrementCurrentIndex()
              onAccepted: root.accepted()
            }
            // Clock { }
          }}
        }
      }
      Component {
        id: topBar
        Rectangle {
          color: "transparent"
          anchors.fill: parent

          RowLayout {
            anchors.fill: parent
            spacing: 0
            Rectangle {
              id: leftSection
              Layout.fillWidth: true
              Layout.fillHeight: true
              color: "transparent"
              RowLayout {
                spacing: Style.spacing.p1
                anchors.left: parent.left
                anchors.leftMargin: Style.spacing.p1
                anchors.fill: parent
              }
            }
            Rectangle {
              id: centerSection
              color: "transparent"
              Layout.fillHeight: true
              Layout.fillWidth: true
              RowLayout {
                spacing: Style.spacing.p1
                anchors.centerIn: parent
                Workspaces { monitorId: root.monitorId }
              }
            }
            Rectangle {
              id: rightSection
              Layout.fillHeight: true
              Layout.fillWidth: true
              color: "transparent"
              RowLayout {
                spacing: Style.spacing.p1
                anchors.right: parent.right
                anchors.rightMargin: Style.spacing.p1
              }
            }
          }
        }
      }
    }
