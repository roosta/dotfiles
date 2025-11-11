pragma ComponentBehavior: Bound
// import Quickshell
import QtQuick
import QtQuick.Layouts

// import Qt5Compat.GraphicalEffects
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Hyprland
import qs.services
// import qs.utils
import qs.config
import qs.components
import Qt5Compat.GraphicalEffects
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
      let iconCount = Apps.getWsIcons(workspaceId).length ?? 0;
      return iconCount * (root.iconSize + Appearance.spacing.p3);
    } else {
      return root.iconSize + Appearance.spacing.p3;
    }
  }

  onPressed: {
    if (workspaceId !== activeWorkspaceId) {
      Hyprland.dispatch(`workspace ${workspaceId}`)
    }
  }
  HoverHandler {
    id: hover
    cursorShape: Qt.PointingHandCursor
  }

  background: BorderRectangle {
    id: wsBackground
    implicitWidth: root.calculatedWidth
    implicitHeight: childrenRect.height
    radius: Appearance.bar.radius
    color: Appearance.srcery.black
    borderColor: Appearance.srcery.gray4

    Loader {
      active: !root.isOccupied
      sourceComponent: indicator
    }
    Component {
      id: indicator
      Item {
        implicitWidth: root.iconSize + Appearance.spacing.p3
        implicitHeight: root.iconSize + Appearance.spacing.p3

        states: [
          State {
            name: "hover"
            when: root.hovered && !root.active
            PropertyChanges {
              circle.color: Appearance.srcery.brightWhite
            }
          },
          State {
            name: "active"
            when: !root.hovered && root.active
            PropertyChanges {
              circle.color: Appearance.srcery.brightWhite
            }
          },

          State {
            name: "normal"
            when: !root.hovered && !root.active
            PropertyChanges {
              circle.color: Appearance.srcery.gray6
            }
          }
        ]
        transitions: [
          Transition {
            ColorAnimation { 
              duration: Appearance.durations.small
              easing.type: Easing.OutQuad 
            }
          }
        ]
        Rectangle {
          id: circle
          anchors.centerIn: parent
          width: root.buttonSize * 0.25
          color: Appearance.srcery.gray6
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
          model: Apps.getWsIcons(root.workspaceId)
          Item {
            required property var modelData
            property bool urgent:  {
              return HyprlandData.urgentWindows.some(win => {
                return root.urgent && win.class === modelData.class 
              })
            }
            
            id: appIcon
            Layout.preferredWidth: root.iconSize + Appearance.spacing.p3
            Layout.preferredHeight: root.iconSize + Appearance.spacing.p3

            onUrgentChanged: {
              if (!urgent) {
                blinkAnimation.running = false
                desaturatedIcon.opacity = 1.0
              }
            }
            states: [ 
              State {
                name: "urgent_active"
                when: appIcon.urgent && root.active
                PropertyChanges { 
                  blinkAnimation.running: true 
                  desaturatedIcon.desaturation: 0.0
                }
              },
              State {
                name: "urgent"
                when: appIcon.urgent && !root.active
                PropertyChanges { 
                  blinkAnimation.running: true 
                  desaturatedIcon.desaturation: 0.8
                }
              },
              State {
                name: "hovered"
                when: !appIcon.urgent && !root.active && hover.hovered
                PropertyChanges { 
                  blinkAnimation.running: false 
                  desaturatedIcon.opacity: 1.0
                  desaturatedIcon.desaturation: 0.0
                }
              },
              State {
                name: "active"
                when: !appIcon.urgent && root.active 
                PropertyChanges { 
                  blinkAnimation.running: false 
                  desaturatedIcon.opacity: 1.0
                  desaturatedIcon.desaturation: 0.0
                }
              },
              State {
                name: "normal"
                when: !appIcon.urgent && !root.active && !hover.hovered
                PropertyChanges { 
                  blinkAnimation.running: false 
                  desaturatedIcon.opacity: 1.0
                  desaturatedIcon.desaturation: 0.8
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
                duration: Appearance.durations.normal
                easing.type: Easing.InOutQuad
              }
              PropertyAnimation {
                target: desaturatedIcon
                property: "opacity" 
                from: 0.3
                to: 1.0
                duration: Appearance.durations.normal
                easing.type: Easing.InOutQuad
              }
            }

            Desaturate {
              id: desaturatedIcon
              implicitWidth: root.iconSize
              implicitHeight: root.iconSize
              anchors.centerIn: parent

              Behavior on desaturation {
                NumberAnimation { 
                  properties: "desaturation"
                  duration: Appearance.durations.small
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
  //     PropertyChanges { root.desaturation: 0.0 }
  //   }
  // ]
}
