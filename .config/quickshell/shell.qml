//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma UseQApplication
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
        exclusionMode: ExclusionMode.Ignore
        name: "wallpaper"
        screen: scope.modelData
        anchors.left: true
        anchors.right: true
        anchors.top: true
        anchors.bottom: true
        Wallpaper { monitorId: scope.monitorId }
      }

      NamedPanel {
        id: exclusion
        WlrLayershell.layer: WlrLayer.Bottom
        name: "exclusion"
        screen: scope.modelData
        anchors.bottom: true
        anchors.left: true
        anchors.right: true
        property int hcalc: {
          if (GlobalState.launcherOpen && GlobalState.launcherMonitorId === scope.monitorId) {
            return Appearance.bar.height + Appearance.launcher.height
          }
          return Appearance.bar.height
        }
        exclusiveZone: hcalc
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
          active: GlobalState.launcherOpen && GlobalState.launcherMonitorId === scope.monitorId
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
            if (GlobalState.overlayOpen) {
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
                if (GlobalState.overlayOpen) {
                  Intersection.Combine
                } else {
                  Intersection.Subtract
                }
              }
            },
            Region {
              x: toast.x
              y: toast.y
              width: toast.implicitWidth
              height: toast.implicitHeight
              intersection: {
                if (Notifications.popupList.length) {
                  Intersection.Subtract
                } else {
                  Intersection.Combine
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
          Bar {
            id: bar
            monitorId: scope.monitorId
          }

          Launcher {
            id: launcher
            monitorId: scope.monitorId
          }

          Toast {
            id: toast
            monitorId: scope.monitorId
            menuRect: trayMenu.item ? trayMenu.item.menuRect : Qt.rect(0,0,0,0)

          }

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
        }
      }
    }
  }
}
