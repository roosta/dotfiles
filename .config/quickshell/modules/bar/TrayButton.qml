pragma ComponentBehavior: Bound
import qs.config
import qs.components
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

import QtQuick.Controls

ExpandingButton {
  id: root
  buttonLabel: SystemTray.items.values.length

  Repeater {
    id: items
    model: root.active ? SystemTray.items : null
    visible: root.active
    TrayItem {}
  }
}
