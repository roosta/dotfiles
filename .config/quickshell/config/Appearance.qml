pragma Singleton

import Quickshell
import QtQuick
import "../../srcery/srcery-gui/qt"

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
}
