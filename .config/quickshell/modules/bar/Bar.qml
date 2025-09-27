import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.components
import qs.config
pragma ComponentBehavior: Bound

Scope {
  id: bar

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: panel
      required property ShellScreen modelData
      color: "transparent"
      screen: modelData

      anchors {
        bottom: true
        left: true
        right: true
      }

      implicitHeight: Appearance.bar.height
      property string monitorId: modelData?.name ?? "FALLBACK"

      anchors {
        bottom: true
        left: true
        right: true
      }

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
            sourceComponent: {
              if (panel.monitorId === Config.monitors?.left) {
                return leftBar
              } else if (panel.monitorId === Config.monitors?.right){
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
                ActiveWindow { }
              }
              RowLayout {
                id: centerSection
                spacing: Appearance.spacing.p1

                LauncherButton { }

                Workspaces { 
                  monitorId: panel.monitorId
                }

                NotificationButton {}
              }
              RowLayout {
                id: rightSection

                // Clock { }
              }} 
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

                  LauncherButton { }

                  Workspaces { 
                    monitorId: panel.monitorId
                  }

                }
                RowLayout {
                  id: centerSection
                  spacing: Appearance.spacing.p1

                }
                RowLayout {
                  id: rightSection

                }} 
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
                      monitorId: panel.monitorId
                    }
                    LauncherButton { }
                    // Clock { }
                  }} 
                }
              }
          }
        }
      }
