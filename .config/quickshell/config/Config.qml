pragma Singleton
import QtQuick
import Quickshell
// import Quickshell.Io

Singleton {
  id: root
  readonly property Workspaces workspaces: Workspaces {}
  readonly property Bar bar: Bar {}
  component Workspaces: QtObject {
    readonly property int shown: 10
  }
  component Bar: QtObject {
    readonly property bool transparent: true
    property int innerHeight: 30
}

}
