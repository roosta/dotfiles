import Quickshell
import "../../config"

Scope {

  Variants {
    model: Quickshell.screens

    PanelWindow {
      property var modelData
      screen: modelData
      color: Appearance.color.srcery.black

      anchors {
        bottom: true
        left: true
        right: true
      }

      implicitHeight: 30

      Clock {
        anchors.centerIn: parent
      }
    }
  }
}
