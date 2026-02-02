pragma Singleton
// pragma ComponentBehavior: Bound
import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property QtObject srcery: QtObject {
    readonly property string black: "#121110"
    readonly property string red: "#EF2F27"
    readonly property string green: "#519F50"
    readonly property string yellow: "#FBB829"
    readonly property string blue: "#2C78BF"
    readonly property string magenta: "#E02C6D"
    readonly property string cyan: "#0AAEB3"
    readonly property string white: "#C5B088"
    readonly property string brightBlack: "#917E6B"
    readonly property string brightRed: "#F75341"
    readonly property string brightGreen: "#98BC37"
    readonly property string brightYellow: "#FED06E"
    readonly property string brightBlue: "#68A8E4"
    readonly property string brightMagenta: "#FF5C8F"
    readonly property string brightCyan: "#2BE4D0"
    readonly property string brightWhite: "#FCE8C3"
    readonly property string orange: "#FF5F00"
    readonly property string brightOrange: "#FF8700"
    readonly property string teal: "#008080"
    readonly property string gray1: "#1C1B19"
    readonly property string gray2: "#262522"
    readonly property string gray3: "#312F2C"
    readonly property string gray4: "#3B3935"
    readonly property string gray5: "#45433E"
    readonly property string gray6: "#504D47"
  }

  readonly property QtObject bar: QtObject {
    readonly property int height: 40 * Config.scale
    readonly property bool transparent: false
    readonly property int radius: 0 * Config.scale
    readonly property real borderWidth: 1 * Config.scale
    readonly property int sliderWidth: 120 * Config.scale
    readonly property real iconSize: 20 * Config.scale
  }

  readonly property QtObject launcher: QtObject {
    readonly property int height: itemHeight * 15 * Config.scale
    readonly property int width: 600 * Config.scale
    readonly property int itemHeight: 50 * Config.scale
    readonly property int inputWidth: 300 * Config.scale
  }

  readonly property QtObject font: QtObject {
    readonly property string main: "Iosevka"
    readonly property string symbols: "Symbols Nerd Font"
    readonly property string light: "Iosevka Light"
    readonly property string extraLight: "Iosevka Extralight"
    readonly property int size0: 10 * Config.scale
    readonly property int size1: 12 * Config.scale
    readonly property int size2: 14 * Config.scale
    readonly property int size3: 16 * Config.scale
    readonly property int size4: 18 * Config.scale

    readonly property int normal: 10 * Config.scale
    readonly property int small: 9 * Config.scale
    readonly property int large: 12 * Config.scale
  }

  readonly property QtObject spacing: QtObject {
    readonly property int p0: 3 * Config.scale
    readonly property int p1: 6 * Config.scale
    readonly property int p2: 8 * Config.scale
    readonly property int p3: 12 * Config.scale
    readonly property int p4: 16 * Config.scale
    readonly property int p5: 24 * Config.scale
  }

  readonly property QtObject durations: QtObject {
    readonly property int normal: 400
    readonly property int small: 200
  }
  // https://github.com/end-4/dots-hyprland/blob/703697e1c40b66619fb224043891aade47494bb3/.config/quickshell/ii/modules/common/Appearance.qml#L225-L242
  readonly property QtObject animationCurves: QtObject {
    readonly property list<real> expressiveFastSpatial: [0.42, 1.67, 0.21, 0.90, 1, 1] // Default, 350ms
    readonly property list<real> expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1.00, 1, 1] // Default, 500ms
    readonly property list<real> expressiveSlowSpatial: [0.39, 1.29, 0.35, 0.98, 1, 1] // Default, 650ms
    readonly property list<real> expressiveEffects: [0.34, 0.80, 0.34, 1.00, 1, 1] // Default, 200ms
    readonly property list<real> emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
    readonly property list<real> emphasizedFirstHalf: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82]
    readonly property list<real> emphasizedLastHalf: [5 / 24, 0.82, 0.25, 1, 1, 1]
    readonly property list<real> emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
    readonly property list<real> emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
    readonly property list<real> standard: [0.2, 0, 0, 1, 1, 1]
    readonly property list<real> standardAccel: [0.3, 0, 1, 1, 1, 1]
    readonly property list<real> standardDecel: [0, 0, 0, 1, 1, 1]
    readonly property real expressiveFastSpatialDuration: 350
    readonly property real expressiveDefaultSpatialDuration: 500
    readonly property real expressiveSlowSpatialDuration: 650
    readonly property real expressiveEffectsDuration: 200
  }
}

