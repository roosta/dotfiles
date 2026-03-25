// ┌────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█▀█░█▀█░▀█▀░█░█░▀█▀░█▀▀░█▀█░█▀█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█▀▀░█▀█░░█░░█▀█░░█░░█░░░█░█░█░█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀░░░▀░▀░░▀░░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>               ├┤
// ││ Repo    : https://github.com/roosta/dotfiles         ││
// ││ Site    : https://www.roosta.sh                      ││
// ├┤ License : GNU General Public License v3              ├┤
// ┆└──────────────────────────────────────────────────────┘┆

import QtQuick
import Quickshell
import QtQuick.VectorImage
// import Quickshell.Widgets

Item {
  id: root
  property string source: ""
  property string iconFolder: Qt.resolvedUrl(Quickshell.shellPath("assets/icons"))  // The folder to check first
  width: 30
  height: 30

  VectorImage {
    id: vectorImage
    anchors.fill: parent
    fillMode: VectorImage.PreserveAspectFit
    source: {
      const fullPathWhenSourceIsIconName = root.iconFolder + "/" + root.source;
      if (root.iconFolder && fullPathWhenSourceIsIconName) {
        return fullPathWhenSourceIsIconName
      }
      return root.source
    }
  }
}
