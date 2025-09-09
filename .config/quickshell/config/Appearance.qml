pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property Spacing spacing: Spacing {}
  readonly property Font font: Font {}
  readonly property Bar bar: Bar {}
  readonly property Srcery srcery: Srcery {}
  readonly property AnimationCurves animationCurves: AnimationCurves {}

  component Srcery: QtObject {
    readonly property color black: "#121110"
    readonly property color red: "#EF2F27"
    readonly property color green: "#519F50"
    readonly property color yellow: "#FBB829"
    readonly property color blue: "#2C78BF"
    readonly property color magenta: "#E02C6D"
    readonly property color cyan: "#0AAEB3"
    readonly property color white: "#C5B088"
    readonly property color brightBlack: "#917E6B"
    readonly property color brightRed: "#F75341"
    readonly property color brightGreen: "#98BC37"
    readonly property color brightYellow: "#FED06E"
    readonly property color brightBlue: "#68A8E4"
    readonly property color brightMagenta: "#FF5C8F"
    readonly property color brightCyan: "#2BE4D0"
    readonly property color brightWhite: "#FCE8C3"
    readonly property color orange: "#FF5F00"
    readonly property color brightOrange: "#FF8700"
    readonly property color teal: "#008080"
    readonly property color gray1: "#1C1B19"
    readonly property color gray2: "#262522"
    readonly property color gray3: "#312F2C"
    readonly property color gray4: "#3B3935"
    readonly property color gray5: "#45433E"
    readonly property color gray6: "#504D47"
  }

  component Bar: QtObject {
    readonly property int height: 40
    readonly property bool transparent: false
    readonly property int radius: 0
  }

  component Font: QtObject {
    readonly property string main: "Iosevka"
    readonly property string symbols: "Symbols Nerd Font"
    readonly property int size0: 8
    readonly property int size1: 12
    readonly property int size2: 16
    readonly property int size3: 20
    readonly property int size4: 24
  }

  component Spacing: QtObject {
    readonly property int p0: 2
    readonly property int p1: 4
    readonly property int p2: 8
    readonly property int p3: 12
    readonly property int p4: 16
  }

  // https://github.com/end-4/dots-hyprland/blob/703697e1c40b66619fb224043891aade47494bb3/.config/quickshell/ii/modules/common/Appearance.qml#L225-L242
  component AnimationCurves: QtObject {
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
