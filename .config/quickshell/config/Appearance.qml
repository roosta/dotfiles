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
    readonly property int height: 40
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
}
