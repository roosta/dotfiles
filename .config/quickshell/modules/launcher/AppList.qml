pragma ComponentBehavior: Bound
import Quickshell
import QtQuick.Layouts
import QtQuick
import qs.config

Rectangle {
  Layout.fillWidth: true
  Layout.fillHeight: true
  color: "transparent"
  ListView {
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom

  }
}
