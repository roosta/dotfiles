//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma IconTheme candy-icons

import Quickshell
import qs.modules.bar
import qs.modules.launcher
import QtQuick
import Quickshell.Wayland
import qs.components
import qs.utils
import qs.config
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

        mask: Region {
          id: mask
          x: 0
          y: 0
          width: main.width
          height: main.height - Appearance.bar.height
          intersection: Intersection.Xor
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

          MouseArea {
            anchors.fill: parent
            onClicked: {
              GlobalState.toggleLauncher(main.screen)
            }
          }
          states: [
            State {
              name: "launcher-open"
              when: GlobalState.launcherOpen && GlobalState.activeMonitorId === scope.monitorId
              PropertyChanges { content.color: Functions.transparentize("#000", 0.7) }
            }
          ]
          transitions: [
            Transition {
              ColorAnimation { 
                duration: 300
                easing.type: Easing.OutQuad 
              }
            }
          ]
          // color: Functions.transparentize("#000", 0.56)
          anchors.fill: parent
          Bar {
            id: bar
            monitorId: scope.monitorId 
          }
          Launcher { 
            monitorId: scope.monitorId
          }
        }
      }
    }
  }
  // Bar { }
}
