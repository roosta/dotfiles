import QtQuick
// import Quickshell.Widgets
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick.Layouts
import qs.services 
import qs.config
pragma ComponentBehavior: Bound

Rectangle {
  id: root
  color: Appearance.srcery.gray1
  required property int show
  readonly property var occupied: HyprlandData.workspaces.reduce((acc, curr) => {
    acc[curr.id] = curr?.windows > 0;
    return acc;
  }, {})
  readonly property HyprlandMonitor monitor: Hyprland.monitorFor(root.QsWindow.window?.screen)
  readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

  // readonly property bool onSpecial: Hyprland.monitorFor(screen)?.lastIpcObject.specialWorkspace.name !== ""
  readonly property int activeWsId: monitor?.activeWorkspace?.id ?? 1
  readonly property int groupOffset: Math.floor((activeWsId - 1) / show) * show
  readonly property int activeIndex: (activeWsId - groupOffset - 1)

  implicitWidth: layout.implicitWidth + Appearance.spacing.p2
  Layout.fillHeight: true
  radius: Appearance.bar.radius
  Item {
    id: inner
    anchors.fill: parent

    // Moving active workspace indicator rectangle
    Rectangle {
      id: activeIndicator
      z: 1
      radius: Appearance.bar.radius
      color: Appearance.srcery.gray4
      height: parent.height - Appearance.spacing.p2

      property real targetX: 0
      property real targetWidth: 0

      function updateIndicator() {
        let x = Appearance.spacing.p1;
        let targetIdx = root.activeIndex;

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
          duration: Appearance.animationCurves.expressiveDefaultSpatialDuration
          easing.type: Easing.BezierSpline
          easing.bezierCurve: Appearance.animationCurves.expressiveDefaultSpatial
        }
      }

      Behavior on width {
        NumberAnimation {
          duration: Appearance.animationCurves.expressiveDefaultSpatialDuration
          easing.type: Easing.BezierSpline
          easing.bezierCurve: Appearance.animationCurves.expressiveDefaultSpatial
        }
      }

      anchors.verticalCenter: parent.verticalCenter
      x: targetX
      width: targetWidth
    }
    RowLayout {
      id: layout
      spacing: Appearance.spacing.p2
      z: 2
      anchors.centerIn: parent
      Repeater {
        model: root.show
        id: workspaceRepeater

        Workspace {
          occupied: root.occupied
          groupOffset: root.groupOffset
          activeWsId: root.activeWsId

          property real calculatedWidth: {
            let wsId = groupOffset + index + 1;
            let isOccupied = occupied[wsId] ?? false;
            if (isOccupied) {
              let iconCount = Icons.getWsIcons(wsId).length;
              return iconCount * (iconSize + Appearance.spacing.p2);
            } else {
              return iconSize + Appearance.spacing.p2;
            }
          }

          onCalculatedWidthChanged: activeIndicator.updateIndicator()
        }
      }
    }

  }

  onActiveIndexChanged: activeIndicator.updateIndicator()
  Component.onCompleted: {
    activeIndicator.updateIndicator();
  }
}
