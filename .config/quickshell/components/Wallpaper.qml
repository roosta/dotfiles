
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
  // Image {
  //   anchors.fill: parent
  //   source: root.wallpaper
  //   fillMode: Image.PreserveAspectCrop
  // }
  VectorImage {
    id: topLevel
    width: 220
    height: 220
    anchors.centerIn: parent
    preferredRendererType: VectorImage.CurveRenderer
    source: `${Paths.assets}/glyph.svg`
  }
  Rectangle {
    property int size: 290
    implicitWidth: size
    implicitHeight: size
    anchors.centerIn: parent
    radius: size / 2
    color: "transparent"
    border.color: Appearance.srcery.gray3
  }
  Rectangle {
    property int size: 310
    implicitWidth: size
    implicitHeight: size
    anchors.centerIn: parent
    radius: size / 2
    color: "transparent"
    border.color: Appearance.srcery.gray3
  }
  Shape {
    id: dashedCircle
    width: 300
    height: 300
    anchors.centerIn: parent

    transform: Rotation {
      origin.x: dashedCircle.width / 2
      origin.y: dashedCircle.height / 2
      NumberAnimation on angle {
        from: 0
        to: 360
        duration: 1000 * 60 * 4
        loops: Animation.Infinite
      }
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
