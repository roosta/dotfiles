// ┌────────────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█▀▄░█▀█░█▀▄░█▀▄░█▀▀░█▀▄░█▀▄░█▀▀░█▀▀░▀█▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█▀▄░█░█░█▀▄░█░█░█▀▀░█▀▄░█▀▄░█▀▀░█░░░░█░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀▀░░▀▀▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░░▀░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>                       ├┤
// ││ Repo    : https://github.com/roosta/dotfiles                 ││
// ││ Site    : https://www.roosta.sh                              ││
// ├┤ License : GNU General Public License v3                      ├┤
// ┆└──────────────────────────────────────────────────────────────┘┆

import QtQuick

Rectangle {
  id: root
  // `color` is the real fill — can be "transparent"
  color: "transparent"

  property color borderColor: "black"
  property int borderWidth: 0
  property int leftBorder: borderWidth
  property int rightBorder: borderWidth
  property int topBorder: borderWidth
  property int bottomBorder: borderWidth

  // Edges drawn individually so the fill stays untouched/transparent
  Rectangle { // top
    color: root.borderColor
    height: root.topBorder
    anchors { top: parent.top; left: parent.left; right: parent.right }
  }
  Rectangle { // bottom
    color: root.borderColor
    height: root.bottomBorder
    anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
  }
  Rectangle { // left
    color: root.borderColor
    width: root.leftBorder
    anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
  }
  Rectangle { // right
    color: root.borderColor
    width: root.rightBorder
    anchors { right: parent.right; top: parent.top; bottom: parent.bottom }
  }
}
