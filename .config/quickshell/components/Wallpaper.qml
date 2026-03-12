// GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
pragma ComponentBehavior: Bound
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
  anchors.bottomMargin: Appearance.bar.height

  Rectangle {
    id: backgroundColor
    anchors.fill: parent
    color: Appearance.srcery.black
  }
  Glyph {
    id: glyph
    width: 220
    height: 220
    anchors.centerIn: parent
  }
  // Shape {
  //   id: sunburst
  //   anchors.centerIn: parent
  //   width: 300
  //   height: 300
  //
  //   property int rayCount: 8
  //   property real innerRadius: 160
  //   property real outerRadius: 200
  //   property real centerX: width / 2
  //   property real centerY: height / 2
  //
  //   ShapePath {
  //     strokeColor: Appearance.srcery.gray4
  //     strokeWidth: 1
  //     fillColor: "transparent"
  //     capStyle: ShapePath.RoundCap
  //
  //     PathSvg {
  //       path: {
  //         let d = "";
  //         for (let i = 0; i < sunburst.rayCount; i++) {
  //           let angle = (i / sunburst.rayCount) * 2 * Math.PI - Math.PI / 2;
  //           let x1 = sunburst.centerX + sunburst.innerRadius * Math.cos(angle);
  //           let y1 = sunburst.centerY + sunburst.innerRadius * Math.sin(angle);
  //           let x2 = sunburst.centerX + sunburst.outerRadius * Math.cos(angle);
  //           let y2 = sunburst.centerY + sunburst.outerRadius * Math.sin(angle);
  //           d += `M ${x1} ${y1} L ${x2} ${y2} `;
  //         }
  //         return d;
  //       }
  //     }
  //   }
  // }

  // The visualizer was based of this:
  // https://github.com/caelestia-dots/shell/blob/3e0360401bbbb0f640958998f6625495e5b3fdff/modules/dashboard/Media.qml
  // Modified 2026 by Daniel Berg <mail@roosta.sh>
  Shape {
    id: visualizer
    anchors.centerIn: parent
    readonly property real centerX: width / 2
    readonly property real centerY: height / 2
    readonly property real innerX: glyph.implicitWidth / 2.7 + Appearance.spacing.p2
    readonly property real innerY: glyph.implicitHeight / 2.7 + Appearance.spacing.p2
    property color colour: Appearance.srcery.gray4

    property int numberOfBars: 64
    anchors.fill: glyph
    anchors.margins: -Appearance.spacing.p1

    asynchronous: true
    preferredRendererType: Shape.CurveRenderer
    data: visualizerBars.instances
  }

  Variants {
    id: visualizerBars

    model: Array.from({
      length: visualizer.numberOfBars
    }, (_, i) => i)

    ShapePath {
      id: visualizerBar

      required property real modelData
      readonly property real value: Math.max(1e-3, Math.min(1, PipewireData.bars[modelData]))

      readonly property real angle: modelData * 2 * Math.PI / visualizer.numberOfBars
      readonly property real magnitude: value * 128
      readonly property real cos: Math.cos(angle)
      readonly property real sin: Math.sin(angle)

      capStyle: ShapePath.SquareCap  // ShapePath.RoundCap
      strokeWidth: Appearance.bar.borderWidth
      strokeColor: Appearance.srcery.gray4

      startX: visualizer.centerX + (visualizer.innerX + strokeWidth / 2) * cos
      startY: visualizer.centerY + (visualizer.innerY + strokeWidth / 2) * sin

      PathLine {
        x: visualizer.centerX + (visualizer.innerX + visualizerBar.strokeWidth / 2 + visualizerBar.magnitude) * visualizerBar.cos
        y: visualizer.centerY + (visualizer.innerY + visualizerBar.strokeWidth / 2 + visualizerBar.magnitude) * visualizerBar.sin
      }

      Behavior on strokeColor {

        ColorAnimation {
          duration: Appearance.durations.normal
          easing.type: Easing.InOutQuad
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
      border.color: Appearance.srcery.gray4
    }
    Rectangle {
      property int size: 302
      implicitWidth: size
      implicitHeight: size
      anchors.centerIn: parent
      radius: size / 2
      color: "transparent"
      border.color: Appearance.srcery.gray4
    }

    Item {
      width: 290
      height: 290
      id: cpuIndicator
      anchors.centerIn: parent

      property real cpuUsage: ResourceUsage.cpuUsage
      property int dotCount: 100
      property real dotSize: 3
      property real circleRadius: 145

      Behavior on cpuUsage {
        NumberAnimation {
          duration: 300
          easing.type: Easing.InOutQuad
        }
      }

      Repeater {
        model: cpuIndicator.dotCount

        Rectangle {
          required property int index
          width: cpuIndicator.dotSize
          height: cpuIndicator.dotSize
          radius: cpuIndicator.dotSize / 2

          // Behavior on color {
          //   ColorAnimation { duration: 300 }
          // }
          color: {
            if (index < cpuIndicator.cpuUsage * cpuIndicator.dotCount) {
              if (cpuIndicator.cpuUsage > 0.8) return Appearance.srcery.orange
              if (cpuIndicator.cpuUsage > 0.5) return Appearance.srcery.yellow
              return Appearance.srcery.white
            } else {
              return Appearance.srcery.gray4
            }
          }

          x: cpuIndicator.width / 2 - width / 2 + cpuIndicator.circleRadius * Math.cos(angle)
          y: cpuIndicator.height / 2 - height / 2 + cpuIndicator.circleRadius * Math.sin(angle)

          property real angle: (index / cpuIndicator.dotCount) * 2 * Math.PI - Math.PI / 2
        }
      }
    }
  }
}
