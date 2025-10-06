pragma ComponentBehavior: Bound
import Quickshell
import QtQuick.Layouts
import QtQuick
import qs.config
import qs.services

Rectangle {
  required property SearchField search
  Layout.fillWidth: true
  Layout.fillHeight: true
  
  Layout.topMargin: Appearance.spacing.p4
  Layout.leftMargin: Appearance.spacing.p4
  Layout.rightMargin: Appearance.spacing.p4
  // Layout.bottomMargin: -5
  color: "transparent"
  clip: true


  ListView {
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    spacing: Appearance.spacing.p2
    model: AppSearch.list
    delegate: AppItem { }

  }
}
