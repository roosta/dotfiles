pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  // readonly property Srcery rounding: Rounding {}
  // readonly property Spacing spacing: Spacing {}
  // readonly property Padding padding: Padding {}
  readonly property Font font: Font {}
  readonly property Color color: Color {}

  component FontFamily: QtObject {
    readonly property string main: "Iosevka"
    readonly property string symbols: "Symbols Nerd Font"
  }

  component FontSize: QtObject {
    readonly property int normal: 15
    readonly property int large: 18
  }

  component Font: QtObject {
    readonly property FontFamily family: FontFamily {}
    readonly property FontSize size: FontSize {}
  }

  component Color: QtObject {
    readonly property Srcery srcery: Srcery {}
  }

  component Srcery: QtObject {
    readonly property color black: "#1C1B19"
    readonly property color red: "#EF2F27"
    readonly property color green: "#519F50"
    readonly property color yellow: "#FBB829"
    readonly property color blue: "#2C78BF"
    readonly property color magenta: "#E02C6D"
    readonly property color cyan: "#0AAEB3"
    readonly property color white: "#BAA67F"
    readonly property color brightBlack: "#918175"
    readonly property color brightRed: "#F75341"
    readonly property color brightGreen: "#98BC37"
    readonly property color brightYellow: "#FED06E"
    readonly property color brightBlue: "#68A8E4"
    readonly property color brightMagenta: "#FF5C8F"
    readonly property color brightCyan: "#2BE4D0"
    readonly property color brightWhite: "#FCE8C3"
    readonly property color orange: "#FF5F00"
    readonly property color brightOrange: "#FF8700"
    readonly property color teal: "#008080";
    readonly property color hardBlack: "#121212";
    readonly property color xgray1: "#262626"
    readonly property color xgray2: "#303030"
    readonly property color xgray3: "#3A3A3A"
    readonly property color xgray4: "#444444"
    readonly property color xgray5: "#4E4E4E"
    readonly property color xgray6: "#585858"
    readonly property color xgray7: "#626262"
    readonly property color xgray8: "#6C6C6C"
    readonly property color xgray9: "#767676"
    readonly property color xgray10: "#808080"
    readonly property color xgray11: "#8A8A8A"
    readonly property color xgray12: "#949494"
  }
}
