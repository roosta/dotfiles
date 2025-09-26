pragma ComponentBehavior: Bound
// import Quickshell
import QtQuick
import QtQuick.Layouts

// import Qt5Compat.GraphicalEffects
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Hyprland
// import qs.services
import qs.config
import qs.components
// import qs.widgets

Button {
  id: root
  required property var occupied
  required property int workspaceId
  required property int activeWorkspaceId
  readonly property bool isOccupied: occupied[workspaceId] ?? false
  readonly property bool isWorkspace: true

  property int buttonSize: 26 * Config.scale
  property int iconSize: 16 * Config.scale

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
    implicitWidth: childrenRect.width
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
          model: Icons.getWsIcons(root.workspaceId)
          Item {
            required property var modelData
            id: appIcon
            Layout.preferredWidth: root.iconSize + Appearance.spacing.p3
            Layout.preferredHeight: root.iconSize + Appearance.spacing.p3
            IconImage {
              source: appIcon.modelData 
              anchors.centerIn: parent
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
  states: [
    State {
      name: "hovered"
      when: root.hovered
      PropertyChanges { wsBackground.topBorder: Appearance.bar.borderWidth }
    }
  ]
}
