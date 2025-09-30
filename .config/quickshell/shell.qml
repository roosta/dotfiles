//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma IconTheme candy-icons

import Quickshell
import qs.modules.bar
import qs.modules.launcher
import Quickshell.Wayland
import qs.components
import qs.config

ShellRoot {
  Variants {
    model: Quickshell.screens
    Scope {
      id: scope
      required property ShellScreen modelData
      property string monitorId: modelData?.name ?? "FALLBACK"

      NamedPanel {
        id: exclusion
        name: "exclusion"
        screen: scope.modelData
        anchors.bottom: true
        implicitWidth: 1
        color: "transparent"
        implicitHeight: 1
        exclusiveZone: Appearance.bar.height
      }

      NamedPanel {
        id: main
        name: "main"
        // color: "#68a8e440"
        color: "transparent"
        screen: scope.modelData
        // implicitHeight: Appearance.bar.height

        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        anchors {
          bottom: true
          left: true
          right: true
          top: true
        }

        mask: Region {
          id: mask
          x: 0
          y: 0
          width: main.width
          height: main.height - Appearance.bar.height
          intersection: Intersection.Xor
        }

        Bar {
          id: bar
          monitorId: scope.monitorId 
        }
        Launcher { }
      }
    }
  }
  // Bar { }
}
