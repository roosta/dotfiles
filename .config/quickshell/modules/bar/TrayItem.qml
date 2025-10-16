pragma ComponentBehavior: Bound

import qs.config
import qs.services

import Quickshell.Widgets
import Quickshell.Services.SystemTray
import Quickshell
import QtQuick

MouseArea {
  id: root
  required property SystemTrayItem modelData
  acceptedButtons: Qt.LeftButton | Qt.RightButton
  implicitWidth: Appearance.font.size3
  implicitHeight: Appearance.font.size3
  
  onClicked: event => {
    switch (event.button) {
      case Qt.LeftButton:
        modelData.activate();
      break;
      case Qt.RightButton:
        const win = root.QsWindow?.window
        if (modelData.hasMenu) {
          modelData.display(
            win,
            win.width - Appearance.spacing.p1,
            win.height - Appearance.bar.height - Appearance.spacing.p1
          );
        }
      break;
    }
    event.accepted = true;
  }
  IconImage {
    id: icon
    anchors.fill: parent
    source: {
      // TODO: make better
      // NOTE: spotify tray icon doesn't load properly, qs sprews out a bunch
      // of warnings, but it isn't null, it is an icon path, just cant load it
      if (root.modelData.id === "spotify-client") {
        return Apps.lookupIcon("spotify")

      }
      return root.modelData.icon
    }
  }
}
