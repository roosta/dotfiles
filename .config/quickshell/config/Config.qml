pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick

Singleton {
  id: root
  readonly property real scale: 1.0
  readonly property string terminal: "kitty"
  readonly property string shell: "zsh"
  readonly property QtObject monitors: QtObject {
    readonly property string left: "DP-2"
    readonly property string right: "HDMI-A-1"
    readonly property string center: "DP-1"
    readonly property string tv: "HDMI-A-2"
  }
}
