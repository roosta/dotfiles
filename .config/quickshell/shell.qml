//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma IconTheme candy-icons

import Quickshell
import qs.modules.bar
import qs.modules.launcher
import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.components
import qs.utils
import qs.config
import qs.services
import qs

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
        implicitHeight: 1
        exclusiveZone: Appearance.bar.height
      }

      NamedPanel {
        id: main
        name: "main"
        screen: scope.modelData

        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        WlrLayershell.keyboardFocus: GlobalState.launcherOpen
        ? WlrKeyboardFocus.OnDemand
        : WlrKeyboardFocus.None

        HyprlandFocusGrab {
          id: grab
          windows: [main]
          active: GlobalState.launcherOpen && GlobalState.activeMonitorId === scope.monitorId
          onCleared: {
            GlobalState.closeLauncher();
          }
        }
        mask: Region {
          id: mask
          x: 0
          y: 0
          width: main.width
          height: main.height
          intersection: {
            if (GlobalState.launcherOpen) {
              Intersection.Combine
            } else {
              Intersection.Xor
            }
          }
          regions: [
            Region {
              x: bar.x
              y: bar.y
              width: bar.width
              height: bar.height
              intersection: {
                if (GlobalState.launcherOpen) {
                  Intersection.Combine
                } else {
                  Intersection.Subtract
                }
              }
            }
          ]
        }

        anchors {
          bottom: true
          left: true
          right: true
          top: true
        }
        Rectangle {
          id: content
          color: "transparent"
          anchors.fill: parent
          // color: Functions.transparentize("#000", 0.56)

          Bar {
            id: bar
            monitorId: scope.monitorId 
          }
          Loader {
            active: Apps.ready
            anchors.fill: parent
            sourceComponent: Launcher { 
              id: launcher
              monitorId: scope.monitorId
            }
          }
        }
      }
    }
  }
  // Bar { }
}
