// ┌────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█▀▀░█▀█░█▀█░▀█▀░█▀▀░█░█░▀█▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█░░░█░█░█░█░░█░░█▀▀░▄▀▄░░█░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀░▀░░▀░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>           ├┤
// ││ Repo    : https://github.com/roosta/dotfiles     ││
// ││ Site    : https://www.roosta.sh                  ││
// ├┤ License : GNU General Public License v3          ├┤
// ┆└──────────────────────────────────────────────────┘┆

import qs.services
import qs.config
import qs.utils
import qs.components
import QtQuick
// import QtQuick.Controls
import QtQuick.Layouts
// import Quickshell
// import Quickshell.Hyprland
// import Quickshell.Wayland
import Quickshell.Widgets

Item {
  id: root
  implicitWidth: 200
  RowLayout {
    id: rowLayout
    anchors.fill: parent
    spacing: 0
    BorderRect {
      implicitWidth: Style.bar.height
      implicitHeight: Style.bar.height - Style.bar.borderWidth
      Layout.topMargin: Style.bar.borderWidth
      color: Style.srcery.black
      // rightBorder: Style.bar.borderWidth
      leftBorder: Style.bar.borderWidth
      borderColor: Style.srcery.gray3
      IconImage {
        id: windowIcon
        anchors.centerIn: parent
        source: ContextData.data.icon
        implicitSize: parent.height - Style.spacing.p3
      }
    }
    ColumnLayout {
      id: colLayout
      Layout.fillWidth: true
      spacing: -4
      Text {

        font {
          family: Style.font.light
          pointSize: Style.font.normal
        }

        color: Style.srcery.brightWhite
        text: ContextData.data.title
      }
      Text {
        id: window
        elide: Text.ElideRight
        Layout.fillWidth: true
        Layout.rightMargin: Style.spacing.p5
        font {
          family: Style.font.light
          pointSize: Style.font.small
        }

        color: Style.srcery.white
        text: ContextData.data.desc
      }
    }
  }
}
