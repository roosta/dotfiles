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

      Rectangle {
        id: barContent
        color: bar.transparent ? "transparent" : Appearance.srcery.black
        border.width: Appearance.bar.borderWidth
        border.color: Appearance.srcery.gray2
        anchors {
          right: parent.right
          left: parent.left
          top: parent.top
          bottom: parent.bottom
        }
        Rectangle {
          anchors.fill: parent
          anchors.topMargin: Appearance.bar.borderWidth
          color: "transparent"
          border.pixelAligned: true

          Loader {
            anchors.fill: parent
            sourceComponent: {
              if (barRoot.modelData?.name === "DP-2") {
                return leftBar
              } else if (barRoot.modelData?.name === "HDMI-A-1"){
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
            }
            Workspaces { 
              show: 5
              screen: barRoot.screen
            }
          }
          RowLayout {
            id: centerSection
            anchors.centerIn: parent
            // Clock { }
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
              show: 4
              screen: barRoot.screen
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
              show: 4
              screen: barRoot.screen
            }
          }
        }
      }

    }
  }
}
