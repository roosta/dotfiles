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
// import qs.widgets

Button {
  id: root
  required property var occupied
  required property int workspaceId
  required property int activeWorkspaceId
  readonly property bool isOccupied: occupied[workspaceId] ?? false
  readonly property bool isWorkspace: true

  property int buttonSize: 26
  property int iconSize: 18

  property var color: activeWorkspaceId === workspaceId
    ? Appearance.srcery.brightWhite
    : Appearance.srcery.gray6


  onPressed: Hyprland.dispatch(`workspace ${workspaceId}`)

  background: Rectangle {
    id: wsBackground
    implicitWidth: childrenRect.width
    implicitHeight: childrenRect.height
    radius: Appearance.bar.radius
    color: "transparent"

    Behavior on implicitWidth {
      animation: NumberAnimation {
        duration: Appearance.animationCurves.expressiveEffectsDuration
        easing.type: Easing.BezierSpline
        easing.bezierCurve: Appearance.animationCurves.expressiveEffects

      }
    }
    Loader {
      active: !root.isOccupied
      sourceComponent: indicator
    }
    Component {
      id: indicator
      Item {
        implicitWidth: root.iconSize + Appearance.spacing.p2
        implicitHeight: root.iconSize + Appearance.spacing.p2
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
            Layout.preferredWidth: root.iconSize + Appearance.spacing.p2
            Layout.preferredHeight: root.iconSize + Appearance.spacing.p2
            IconImage {
              source: appIcon.modelData 
              anchors.centerIn: parent
              implicitSize: root.iconSize
            }
          }
        }}
    }
  }
}
