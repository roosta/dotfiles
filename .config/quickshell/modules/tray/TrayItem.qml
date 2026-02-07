// GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
// Author: Daniel Berg <mail@roosta.sh>

pragma ComponentBehavior: Bound

import qs.config
import qs.services
import qs
import qs.utils
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

MouseArea {
  id: root
  required property SystemTrayItem modelData
  acceptedButtons: Qt.LeftButton | Qt.RightButton
  implicitWidth: Appearance.font.size3
  implicitHeight: Appearance.font.size3

  required property string monitorId

  onClicked: event => {
    switch (event.button) {
      case Qt.LeftButton:
        modelData.activate();
        break;
      case Qt.RightButton:
        if (modelData.hasMenu) {
          GlobalState.openTrayMenu(root.modelData.menu)
          ContextData.trayDesc = Functions.capitalize(root.modelData?.title)

          // System menu
          // const win = root.QsWindow?.window
          // if (modelData.hasMenu) {
          //   modelData.display(
          //     win,
          //     win.width - Appearance.spacing.p1,
          //     win.height - Appearance.bar.height - Appearance.spacing.p1
          //   );
          // }
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
        return Icons.lookupIcon("spotify")

      }
      return root.modelData.icon
    }
  }
}
