
import Quickshell
import QtQuick
// import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick.Shapes
import QtQuick.VectorImage

import qs.utils
import qs.services
import qs.config

Item {
  id: root
  anchors.fill: parent
  required property string monitorId

  property var workspaces: HyprlandData.workspacesByMonitor[monitorId] ?? []

  visible: !isOccupied || onlyFloating
  readonly property var occupied: workspaces.reduce((acc, ws) => {
    acc[ws.id] = ws?.windows > 0;
    return acc;
  }, {})
  readonly property HyprlandMonitor monitor: Hyprland
  .monitorFor(root.QsWindow.window?.screen)
  readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
  readonly property int activeWorkspaceId: monitor?.activeWorkspace?.id ?? 1
  property var windows: HyprlandData.windowsByWorkspace[activeWorkspaceId] ?? []
  property bool onlyFloating: windows.every(w => w.floating) ?? false
  readonly property bool isOccupied: occupied[activeWorkspaceId] ?? false
  readonly property string wallpaper: `${Paths.srcery}/srcery-wallpaper/srcery-wallpaper.png`

  Rectangle {
    id: backgroundColor
    anchors.fill: parent
    color: Appearance.srcery.black
  }
  Glyph {
    width: 220
    height: 220
    anchors.centerIn: parent
  }
  Shape {
    id: sunburst
    anchors.centerIn: parent
    width: 300
    height: 300

    property int rayCount: 8
    property real innerRadius: 160
    property real outerRadius: 175
    property real centerX: width / 2
    property real centerY: height / 2

    ShapePath {
      strokeColor: Appearance.srcery.gray3
      strokeWidth: 1
      fillColor: "transparent"
      capStyle: ShapePath.RoundCap

      PathSvg {
        path: {
          let d = "";
          for (let i = 0; i < sunburst.rayCount; i++) {
            let angle = (i / sunburst.rayCount) * 2 * Math.PI - Math.PI / 2;
            let x1 = sunburst.centerX + sunburst.innerRadius * Math.cos(angle);
            let y1 = sunburst.centerY + sunburst.innerRadius * Math.sin(angle);
            let x2 = sunburst.centerX + sunburst.outerRadius * Math.cos(angle);
            let y2 = sunburst.centerY + sunburst.outerRadius * Math.sin(angle);
            d += `M ${x1} ${y1} L ${x2} ${y2} `;
          }
          return d;
        }
      }
    }
  }
  Item {
    id: c1
    anchors.fill: parent
    Rectangle {
      property int size: 280
      implicitWidth: size
      implicitHeight: size
      anchors.centerIn: parent
      radius: size / 2
      color: "transparent"
      border.color: Appearance.srcery.gray3
    }
    Rectangle {
      property int size: 300
      implicitWidth: size
      implicitHeight: size
      anchors.centerIn: parent
      radius: size / 2
      color: "transparent"
      border.color: Appearance.srcery.gray3
    }
    Shape {
      id: dashedCircle
      width: 290
      height: 290
      anchors.centerIn: parent

      transform: Rotation {
        origin.x: dashedCircle.width / 2
        origin.y: dashedCircle.height / 2
        // NumberAnimation on angle {
        //   from: 0
        //   to: 360
        //   duration: 1000 * 60 * 4
        //   loops: Animation.Infinite
        // }
      }
      ShapePath {
        strokeColor: Appearance.srcery.gray3
        strokeWidth: 1
        id: circlePath
        fillColor: "transparent"

        // Dashed line pattern: [dash length, gap length]
        strokeStyle: ShapePath.DashLine
        dashPattern: [4, 10]

        PathAngleArc {
          centerX: dashedCircle.width / 2
          centerY: dashedCircle.height / 2
          radiusX: (dashedCircle.width - circlePath.strokeWidth) / 2
          radiusY: (dashedCircle.height - circlePath.strokeWidth) / 2
          startAngle: 0
          sweepAngle: 360
        }
      }
    }
  }
}
