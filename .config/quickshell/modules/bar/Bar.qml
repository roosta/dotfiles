import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
pragma ComponentBehavior: Bound

Scope {
  id: bar
  property bool transparent: Appearance.bar.transparent

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: barRoot
      required property ShellScreen modelData
      color: "transparent"
      screen: modelData

      anchors {
        bottom: true
        left: true
        right: true
      }

      implicitHeight: Appearance.bar.height

      BorderRectangle {
        id: barContent
        color: Appearance.srcery.black
        borderColor: Appearance.srcery.gray2
        topBorder: 1
        // border.width: Appearance.bar.borderWidth
        // border.color: Appearance.srcery.gray2
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
            property string monitorId: barRoot.modelData?.name ?? "fallback"
            sourceComponent: {
              if (barRoot.modelData?.name === Config.monitors?.left) {
                return leftBar
              } else if (barRoot.modelData?.name === Config.monitors?.right){
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

          RowLayout {
            id: leftSection
            anchors {
              top: parent.top
              left: parent.left
              bottom: parent.bottom
              right: parent.right
            }
            ActiveWindow {
              Layout.fillWidth: true
              Layout.fillHeight: true
            }
          }
          RowLayout {
            id: centerSection
            anchors {
              top: parent.top
              bottom: parent.bottom
              horizontalCenter: parent.horizontalCenter
            }
            Workspaces { 
              monitorId: barLoader.monitorId
            }
          }
          RowLayout {
            id: rightSection
            anchors.right: parent.right
          } 
        }
      }

      Component {
        id: rightBar
        Rectangle {
          color: "transparent"
          RowLayout {
            id: leftSection
            anchors {
              top: parent.top
              left: parent.left
              bottom: parent.bottom
            }
            Workspaces {
              monitorId: barLoader.monitorId
            }
          }
          RowLayout {
            id: centerSection
            anchors.centerIn: parent
            // Clock { }
          }
        }
      }
      Component {
        id: leftBar
        Rectangle {
          color: "transparent"

          RowLayout {
            id: leftSection
            anchors.left: parent.left
          }
          RowLayout {
            id: centerSection
            anchors.centerIn: parent
          }
          RowLayout {
            id: rightSection
            anchors {
              top: parent.top
              right: parent.right
              bottom: parent.bottom
            }
            Workspaces {
              monitorId: barLoader.monitorId
            }
          }
        }
      }
    }
  }
}
