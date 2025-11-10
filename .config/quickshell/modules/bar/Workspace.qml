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

  property var activeTopLevel: Hyprland.activeToplevel?.lastIpcObject
  property bool urgent:  {
    return HyprlandData.urgentWindows.some(win => {
      return win.workspace.id === root.workspaceId
    })
  }
  
  onActiveTopLevelChanged: {
    if (root.urgent && HyprlandData.urgentWindows.some(w => w.address === activeTopLevel.address)) {
      HyprlandData.clearUrgentByClass(activeTopLevel.class)

    }
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

  property var color: activeWorkspaceId === workspaceId
    ? Appearance.srcery.brightWhite
    : Appearance.srcery.gray6


  onPressed: {
    if (workspaceId !== activeWorkspaceId) {
      Hyprland.dispatch(`workspace ${workspaceId}`)
    }
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
        Rectangle {
          anchors.centerIn: parent
          width: root.buttonSize * 0.25
          height: width
          radius: width / 2
          color: root.color
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
                return win.workspace.id === root.workspaceId &&
                  win.class === modelData.class 
              })
            }
            
            id: appIcon
            Layout.preferredWidth: root.iconSize + Appearance.spacing.p3
            Layout.preferredHeight: root.iconSize + Appearance.spacing.p3
            states: [ 
              State {
                name: "urgent"
                when: appIcon.urgent
                PropertyChanges { 
                  blinkAnimation.running: true 
                }
              },
              State {
                name: "normal"
                when: !appIcon.urgent
                PropertyChanges { 
                  blinkAnimation.running: false 
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
              desaturation: 0
              anchors.centerIn: parent
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
  states: [
    State {
      name: "hovered"
      when: root.hovered
      PropertyChanges { wsBackground.bottomBorder: Appearance.bar.borderWidth }
    }
  ]
}
