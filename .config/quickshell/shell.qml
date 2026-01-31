//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma UseQApplication
//@ pragma IconTheme ritual-icons
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic

pragma ComponentBehavior: Bound
import Quickshell
import qs.modules.bar
import qs.modules.launcher
import qs.modules.tray
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
      property string monitorId: modelData?.name ?? ""

      NamedPanel {
        id: wallpaper
        WlrLayershell.layer: WlrLayer.Background
        name: "wallpaper"
        screen: scope.modelData
        anchors.left: true
        anchors.right: true
        anchors.top: true
        anchors.bottom: true
        Wallpaper { monitorId: scope.monitorId }
      }

      NamedPanel {
        id: barPanel
        name: "bar"
        screen: scope.modelData
        anchors.bottom: true
        anchors.left: true
        anchors.right: true
        implicitHeight: Appearance.bar.height
        Bar {
          id: bar
          monitorId: scope.monitorId
        }
      }

      NamedPanel {
        id: contentPanel
        name: "content"
        screen: scope.modelData

        WlrLayershell.keyboardFocus: GlobalState.launcherOpen
          ? WlrKeyboardFocus.OnDemand
          : WlrKeyboardFocus.None

        HyprlandFocusGrab {
          id: grab
          windows: [contentPanel, barPanel]
          active: GlobalState.launcherOpen && GlobalState.launcherMonitorId === scope.monitorId
          onCleared: {
            GlobalState.closeLauncher();
          }
        }

        mask: Region {
          id: mask
          x: 0
          y: 0
          width: contentPanel.width
          height: contentPanel.height
          intersection: GlobalState.overlayOpen ? Intersection.Combine : Intersection.Xor
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
          transitions: [
            Transition {
              ColorAnimation {
                duration: 300
                easing.type: Easing.OutQuad
              }
            }
          ]
          MouseArea {
            anchors.fill: parent
            onClicked: {
              if (GlobalState.launcherOpen) { GlobalState.closeLauncher() }
              if (GlobalState.trayMenuOpen) { GlobalState.closeTrayMenu() }
            }
          }
          states: [
            State {
              name: "open"
              when: GlobalState.overlayOpen
              PropertyChanges { content.color: Functions.transparentize("#000", 0.7) }
            }
          ]
          Loader {
            id: trayMenu
            anchors.fill: parent
            active: GlobalState.trayMenuOpen

            sourceComponent: TrayMenu {
              Component.onCompleted: this.open();
              trayItemMenuHandle: GlobalState.activeMenu
              onMenuOpened: (window) => {};
              onMenuClosed: GlobalState.closeTrayMenu()
              monitorId: scope.monitorId
            }
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
}
