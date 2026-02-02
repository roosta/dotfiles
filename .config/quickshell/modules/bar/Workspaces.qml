import QtQuick
// import Quickshell.Widgets
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick.Layouts
import qs.services
import qs.config
import qs.components
import qs.utils
pragma ComponentBehavior: Bound

BorderRectangle {
  id: root
  leftBorder: Appearance.bar.borderWidth
  rightBorder: Appearance.bar.borderWidth
  borderColor: Appearance.srcery.gray3
  color: Appearance.srcery.black
  required property string monitorId
  property var workspaces: HyprlandData.workspacesByMonitor[monitorId] ?? []
  readonly property var occupied: workspaces.reduce((acc, ws) => {
    acc[ws.id] = ws?.windows > 0;
    return acc;
  }, {})
  readonly property HyprlandMonitor monitor: Hyprland
    .monitorFor(root.QsWindow.window?.screen)
  readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
  readonly property int activeWorkspaceId: monitor?.activeWorkspace?.id ?? 1

  Behavior on implicitWidth {
    NumberAnimation {
      duration: Appearance.durations.small
      easing.type: Easing.InOutCubic
    }
  }
  implicitWidth: layout.implicitWidth + Appearance.spacing.p3 + Appearance.bar.borderWidth * 2
  implicitHeight: Appearance.bar.height - Appearance.bar.borderWidth
  Layout.topMargin: Appearance.bar.borderWidth
  radius: Appearance.bar.radius

  Item {
    id: inner
    anchors.fill: parent

    // Moving active workspace indicator rectangle
    Rectangle {
      id: activeIndicator
      z: 3
      // radius: (parent.height - Appearance.spacing.p3) / 2
      color: "transparent"
      border.color: Appearance.srcery.gray4
      border.width: Appearance.bar.borderWidth
      height: parent.height - Appearance.spacing.p1 * 2

      property real targetX: 0
      property real targetWidth: 0

      function updateIndicator() {
        let x = Appearance.spacing.p1 + Appearance.bar.borderWidth
        let targetIdx = root.workspaces.findIndex(w => {
          return w.id === root.activeWorkspaceId
        });

        for (let i = 0; i < targetIdx && i < workspaceRepeater.count; i++) {
          let item = workspaceRepeater.itemAt(i);
          if (item) {
            x += item.calculatedWidth + layout.spacing;
          }
        }

        let activeItem = workspaceRepeater.itemAt(targetIdx);

        if (activeItem) {
          targetX = x;
          targetWidth = activeItem.calculatedWidth;
        }
      }

      Behavior on x {
        NumberAnimation {
          duration: Appearance.animationCurves
            .expressiveDefaultSpatialDuration
          easing.type: Easing.BezierSpline
          easing.bezierCurve: Appearance.animationCurves
            .expressiveDefaultSpatial
        }
      }

      Behavior on width {
        NumberAnimation {
          duration: Appearance.animationCurves
            .expressiveDefaultSpatialDuration
          easing.type: Easing.BezierSpline
          easing.bezierCurve: Appearance.animationCurves
            .expressiveDefaultSpatial
        }
      }

      anchors.verticalCenter: parent.verticalCenter
      x: targetX
      width: targetWidth
    }
    RowLayout {
      id: layout
      spacing: Appearance.spacing.p1
      z: 2
      anchors.centerIn: parent
      Repeater {
        model: root.workspaces
        id: workspaceRepeater

        Workspace {
          occupied: root.occupied
          activeWorkspaceId: root.activeWorkspaceId;
          workspaceId: modelData?.id;
          onCalculatedWidthChanged: activeIndicator.updateIndicator()
        }
      }
    }

  }

  onActiveWorkspaceIdChanged: activeIndicator.updateIndicator()
  onWorkspacesChanged: activeIndicator.updateIndicator()
  Component.onCompleted: {
    activeIndicator.updateIndicator();
  }

}
