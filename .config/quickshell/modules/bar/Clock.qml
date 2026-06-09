// ┌───────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░░█▀▀░█░░░█▀█░█▀▀░█░█░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░░█░░░█░░░█░█░█░░░█▀▄░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀───────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>      ├┤
// ││ Repo    : https://github.com/roosta/dotfiles││
// ││ Site    : https://www.roosta.sh             ││
// ├┤ License : GNU General Public License v3     ├┤
// ┆└─────────────────────────────────────────────┘┆

import QtQuick
import QtQuick.Layouts
import qs.services
import qs.config
import qs.components

BorderRect {
  implicitWidth: childrenRect.width
  implicitHeight: Style.bar.height - Style.bar.borderWidth
  // topBorder: Style.bar.borderWidth
  rightBorder: Style.bar.borderWidth
  Layout.topMargin: Style.bar.borderWidth
  borderColor: Style.srcery.gray3
  color: Style.srcery.black
  Rectangle {
    implicitWidth: childrenRect.width + Style.spacing.p1
    implicitHeight: parent.height
    color: "transparent"
    ColumnLayout {
      implicitHeight: Style.bar.height - Style.spacing.p1 * 2
      spacing: -4
      anchors.verticalCenter: parent.verticalCenter
      Text {
        Layout.alignment: Qt.AlignRight
        font {
          family: Style.font.light
          pointSize: Style.font.normal
        }

        color: Style.srcery.brightWhite
        text: Time.time
      }
      Text {
        Layout.alignment: Qt.AlignRight
        font {
          family: Style.font.light
          pointSize: Style.font.small
        }

        color: Style.srcery.white
        text: Time.date
      }
    }
  }

}
