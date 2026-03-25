// ┌────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█▀▄░▀█▀░█▀█░█▀▀░█▀▄░█▀█░█▄█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█░█░░█░░█▀█░█░█░█▀▄░█▀█░█░█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀▀░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀░▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>           ├┤
// ││ Repo    : https://github.com/roosta/dotfiles     ││
// ││ Site    : https://www.roosta.sh                  ││
// ├┤ License : GNU General Public License v3          ├┤
// ┆└──────────────────────────────────────────────────┘┆
pragma ComponentBehavior: Bound
import QtQuick
import qs.config

Item {
  id: root
  anchors.centerIn: parent
  Rectangle {
    anchors.fill: parent
    border.width: Appearance.bar.borderWidth
    rotation: 45
    border.color: Appearance.srcery.gray4
    color: "transparent"
  }

  Rectangle {
    anchors.fill: parent
    border.color: Appearance.srcery.black
    color: "transparent"
    border.width: 15
  }

  Rectangle {
    anchors.centerIn: parent
    border.color: Appearance.srcery.gray4
    border.width: Appearance.bar.borderWidth
    implicitWidth: parent.implicitWidth - 30
    implicitHeight: parent.implicitHeight - 30
    color: "transparent"
  }

  Rectangle {
    anchors.fill: parent
    border.width: Appearance.bar.borderWidth
    border.color: Appearance.srcery.gray4
    color: "transparent"
  }
}
