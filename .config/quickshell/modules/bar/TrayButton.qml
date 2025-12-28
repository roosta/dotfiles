pragma ComponentBehavior: Bound
// import qs.config
import qs.components
import qs.modules.tray
import QtQuick
// import QtQuick.Layouts
import Quickshell.Services.SystemTray
import qs

// import QtQuick.Controls

ExpandingButton {
  id: root
  buttonLabel: SystemTray.items.values.length

  preventAutoClose: GlobalState.trayMenuOpen
  Repeater {
    id: items
    model: root.active ? SystemTray.items : null
    visible: root.active
    TrayItem { monitorId: root.monitorId }
  }
}
