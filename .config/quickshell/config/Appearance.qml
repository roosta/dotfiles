pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  readonly property Spacing spacing: Spacing {}
  readonly property Font font: Font {}
  readonly property Bar bar: Bar {}
  readonly property Srcery srcery: Srcery {}

  component Bar: QtObject {
    readonly property int height: 32
  }

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

  component Spacing: QtObject {
    readonly property int p0: 2
    readonly property int p1: 4
    readonly property int p2: 8
    readonly property int p3: 12
    readonly property int p4: 16
  }
}
