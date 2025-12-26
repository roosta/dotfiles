// GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
// Source: https://github.com/end-4/dots-hyprland/blob/5c141e0361adabdb7ea3575392309bec3a592af9/dots/.config/quickshell/ii/modules/ii/bar/SysTrayItem.qml
// Modified by Daniel Berg 2025 <mail@roosta.sh>

pragma ComponentBehavior: Bound

import qs.config
import qs.services
import qs

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
  property bool targetMenuOpen: false

  signal menuOpened(qsWindow: var)
  signal menuClosed()
  
  onClicked: event => {
    switch (event.button) {
      case Qt.LeftButton:
        modelData.activate();
        break;
      case Qt.RightButton:
        if (modelData.hasMenu) { menu.open();}
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
  
  Loader {
    id: menu
    function open() {
      menu.active = true;
    }
    active: false
    sourceComponent: TrayMenu {
      Component.onCompleted: this.open();
      trayItemMenuHandle: root.modelData.menu
      anchor {
        window: root.QsWindow.window
        rect.x: QsWindow.window?.width
        rect.y: QsWindow.window?.height - Appearance.bar.height
        rect.height: root.height
        rect.width: root.width
        edges: (Edges.Top | Edges.Left)
        gravity: (Edges.Top | Edges.Left)
      }
      onMenuOpened: (window) => root.menuOpened(window);
      onMenuClosed: {
        root.menuClosed();
        menu.active = false;
      }
    }
  }
}
