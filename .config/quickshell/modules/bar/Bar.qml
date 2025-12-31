import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.components
import qs.services
import qs.config
pragma ComponentBehavior: Bound

Item {
  id: root
  required property string monitorId

  z: 1
  implicitHeight: Appearance.bar.height

  anchors {
    bottom: parent.bottom
    left: parent.left
    right: parent.right
  }

  BorderRectangle {
    id: barContent
    color: Appearance.srcery.black
    borderColor: Appearance.srcery.gray3
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
              spacing: Appearance.spacing.p1
              anchors.left: parent.left
              anchors.leftMargin: Appearance.spacing.p1 - Appearance.bar.borderWidth
              anchors.fill: parent
              AlertsIndicator { monitorId: root.monitorId }
              KeyboardButton { monitorId: root.monitorId }
              Loader {
                Layout.fillHeight: true
                Layout.fillWidth: true
                active: Apps.ready
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
              spacing: Appearance.spacing.p1
              anchors.centerIn: parent
              LauncherButton { monitorId: root.monitorId }
              Workspaces { monitorId: root.monitorId }
              NotificationButton {}
            }
          }
          Rectangle {
            id: rightSection
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "transparent"
            RowLayout {
              spacing: Appearance.spacing.p1
              anchors.right: parent.right
              anchors.rightMargin: Appearance.spacing.p1
              Clock { }
              TrayButton { monitorId: root.monitorId }
              AudioButton { monitorId: root.monitorId }
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
            spacing: Appearance.spacing.p1
            Layout.leftMargin: Appearance.spacing.p1

            LauncherButton { monitorId: root.monitorId }

            Workspaces {
              monitorId: root.monitorId
            }

          }
          RowLayout {
            id: centerSection
            spacing: Appearance.spacing.p1

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
            spacing: Appearance.spacing.p1

            // NotificationButton {}
          }
          RowLayout {
            id: rightSection
            spacing: Appearance.spacing.p1
            Layout.rightMargin: Appearance.spacing.p1
            Workspaces {
              monitorId: root.monitorId
            }
            LauncherButton { monitorId: root.monitorId }
            // Clock { }
          }}
        }
      }
    }


