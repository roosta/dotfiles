// ┌────────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█░█░█▀█░█▀▄░█░█░█▀▀░█▀█░█▀█░█▀▀░█▀▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█▄█░█░█░█▀▄░█▀▄░▀▀█░█▀▀░█▀█░█░░░█▀▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░░░▀░▀░▀▀▀░▀▀▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>                   ├┤
// ││ Repo    : https://github.com/roosta/dotfiles             ││
// ││ Site    : https://www.roosta.sh                          ││
// ├┤ License : GNU General Public License v3                  ├┤
// ┆└──────────────────────────────────────────────────────────┘┆

pragma ComponentBehavior: Bound
// import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Hyprland
import qs.services
// import qs.utils
import qs.config
import qs.components
import qs.utils
// import qs.widgets

Button {
  id: root
  required property var occupied
  required property int workspaceId
  required property int activeWorkspaceId
  readonly property bool isOccupied: occupied[workspaceId] ?? false
  readonly property bool isWorkspace: true
  required property var modelData
  property bool active: activeWorkspaceId === workspaceId
  property bool urgent: {
    return HyprlandData.urgentWindows.some(win => {
      return win.workspace.id === root.workspaceId
    })
  }


  property int buttonSize: 26 * Config.scale
  property int iconSize: 16 * Config.scale
  property int calculatedWidth: {
    if (root.isOccupied) {
      let iconCount = Icons.getWsIcons(workspaceId).length ?? 0;
      return iconCount * (root.iconSize + Style.spacing.p3);
    } else {
      return root.iconSize + Style.spacing.p3;
    }
  }

  onPressed: {
    if (workspaceId !== activeWorkspaceId) {
      Hyprland.dispatch(`hl.dsp.focus({ workspace = ${workspaceId} })`)
    }
  }
  HoverHandler {
    id: hover
    cursorShape: root.active ? Qt.ArrowCursor : Qt.PointingHandCursor
  }

  background: Rectangle {
    id: wsBackground
    implicitWidth: root.calculatedWidth
    implicitHeight: childrenRect.height
    radius: Style.bar.radius
    color: "transparent"
    border.color: Style.srcery.gray2

    border.width: root.isOccupied ? 1 : 0

    Behavior on border.color {
      ColorAnimation {
        duration: Style.durations.normal
        easing.type: Easing.OutCubic
      }
    }
    Loader {
      active: !root.isOccupied
      sourceComponent: indicator
    }
    Component {
      id: indicator
      Item {
        implicitWidth: root.iconSize + Style.spacing.p3
        implicitHeight: Style.bar.height - Style.bar.borderWidth
        - Style.spacing.p1 * 2

        states: [
          State {
            name: "hover"
            when: root.hovered && !root.active
            PropertyChanges {
              circle.color: Style.srcery.brightWhite
            }
          },
          State {
            name: "active"
            when: !root.hovered && root.active
            PropertyChanges {
              circle.color: Style.srcery.brightWhite
            }
          },

          State {
            name: "hoveredActive"
            when: root.hovered && root.active
            PropertyChanges {
              circle.color: Style.srcery.brightWhite
            }
          },
          State {
            name: "normal"
            when: !root.hovered && !root.active
            PropertyChanges {
              circle.color: Style.srcery.gray6
            }
          }
        ]
        transitions: [
          Transition {
            ColorAnimation {
              duration: Style.durations.small
              easing.type: Easing.OutQuad
            }
          }
        ]
        Rectangle {
          id: circle
          anchors.centerIn: parent
          width: root.buttonSize * 0.25
          color: Style.srcery.gray6
          height: width
          radius: width / 2
        }
      }
    }

    Loader {
      active: root.isOccupied
      sourceComponent: iconGroup
    }
    Component {
      id: iconGroup
      RowLayout {
        spacing: 0
        Repeater {
          model: Icons.getWsIcons(root.workspaceId)
          Item {
            required property var modelData
            property bool urgent:  {
              return HyprlandData.urgentWindows.some(win => {
                return root.urgent && win.class === modelData.class
              })
            }

            id: appIcon
            Layout.preferredWidth: root.iconSize + Style.spacing.p3
            Layout.preferredHeight: Style.bar.height - Style.bar.borderWidth - Style.spacing.p1 * 2

            onUrgentChanged: {
              if (!urgent) {
                blinkAnimation.running = false
                // desaturatedIcon.opacity = 1.0
              }
            }
            states: [
              State {
                name: "urgent_active"
                when: appIcon.urgent && root.active && !hover.hovered
                PropertyChanges {
                  blinkAnimation.running: true
                }
              },
              State {
                name: "urgent"
                when: appIcon.urgent && !root.active && !hover.hovered
                PropertyChanges {
                  blinkAnimation.running: true
                }
              },
              State {
                name: "hovered"
                when: !appIcon.urgent && !root.active && hover.hovered
                PropertyChanges {
                  blinkAnimation.running: false
                  wsBackground.border.color: Style.srcery.brightBlack
                  // desaturatedIcon.opacity: 1.0
                }
              },
              State {
                name: "UrgentHovered"
                when: appIcon.urgent && !root.active && hover.hovered
                PropertyChanges {
                  blinkAnimation.running: true
                  wsBackground.border.color: Style.srcery.gray6
                }
              },
              State {
                name: "active"
                when: !appIcon.urgent && root.active  && !hover.hovered
                PropertyChanges {
                  blinkAnimation.running: false
                  wsBackground.border.color: Style.srcery.brightBlack
                  desaturatedIcon.opacity: 1.0
                }
              },
              State {
                name: "activeHovered"
                when: !appIcon.urgent && root.active  && hover.hovered
                PropertyChanges {
                  blinkAnimation.running: false
                  wsBackground.border.color: Style.srcery.brightBlack
                  desaturatedIcon.opacity: 1.0
                }
              },
              State {
                name: "normal"
                when: !appIcon.urgent && !root.active && !hover.hovered
                PropertyChanges {
                  blinkAnimation.running: false
                  wsBackground.border.color: Style.srcery.gray2
                  desaturatedIcon.opacity: 1.0
                }
              }

            ]
            SequentialAnimation {
              id: blinkAnimation
              running: false
              loops: Animation.Infinite

              PropertyAnimation {
                target: desaturatedIcon
                property: "opacity"
                from: 1.0
                to: 0.3
                duration: Style.durations.normal
                easing.type: Easing.InOutQuad
              }
              PropertyAnimation {
                target: desaturatedIcon
                property: "opacity"
                from: 0.3
                to: 1.0
                duration: Style.durations.normal
                easing.type: Easing.InOutQuad
              }
              // PropertyAnimation {
              //   target: desaturatedIcon
              //   property: "opacity"
              //   from: 0.3
              //   to: 1.0
              //   duration: Style.durations.normal
              //   easing.type: Easing.InOutQuad
              // }
            }

            MultiEffect {
              id: desaturatedIcon
              implicitWidth: root.iconSize
              implicitHeight: root.iconSize
              anchors.centerIn: parent

              Behavior on saturation {
                NumberAnimation {
                  properties: "saturation"
                  duration: Style.durations.small
                  easing.type: Easing.OutCubic
                }
              }
              source: IconImage {
                source: appIcon.modelData.icon
                implicitSize: root.iconSize

                // opacity: 0
                // scale: 0.8
                //
                // Component.onCompleted: {
                //   opacity = 1
                //   scale = 1
                // }
                //
                // Behavior on opacity {
                //   NumberAnimation {
                //     duration: 300
                //     easing.type: Easing.OutCubic
                //   }
                // }
                //
                // Behavior on scale {
                //   NumberAnimation {
                //     duration: 300
                //     easing.type: Easing.OutCubic
                //   }
                // }
              }
            }


          }
        }
      }
    }
  }
  // states: [
  //   State {
  //     name: "hovered"
  //     when: root.hovered
  //     PropertyChanges { root.saturation: 0.0 }
  //   }
  // ]
}
