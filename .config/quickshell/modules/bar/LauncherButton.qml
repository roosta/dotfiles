import qs.services
import qs.config
import qs.utils
import QtQuick
// import QtQuick.Controls
import QtQuick.Layouts

import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets

Button {
  id: root
  property int size: 20

  // color: Appearance.srcery.brightWhite

  Layout.topMargin: Appearance.bar.borderWidth
  implicitWidth: parent.height - Appearance.spacing.p3
  implicitHeight: parent.height - Appearance.spacing.p3

  background: BorderRectangle {
    color: Appearance.srcery.black
    borderColor: Appearance.srcery.gray3
    borderWidth: Appearance.bar.borderWidth
    BorderRectangle {
      anchors.centerIn: parent
      implicitWidth: parent.width * 0.5
      implicitHeight: parent.height * 0.5
      borderWidth: Appearance.bar.borderWidth
      color: Appearance.srcery.black
      rotation: 45
      borderColor: Appearance.srcery.gray3

    }
  }
}
