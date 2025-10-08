pragma ComponentBehavior: Bound
import Quickshell
import QtQuick.Layouts
import QtQuick.Templates
import QtQuick
import qs.config
import qs.components
import qs.services

Rectangle {
  id: root
  required property SearchField search
  Layout.fillWidth: true
  Layout.fillHeight: true
  
  Layout.topMargin: Appearance.bar.borderWidth
  Layout.leftMargin: Appearance.spacing.p4 + Appearance.bar.borderWidth
  Layout.rightMargin: Appearance.spacing.p4 + Appearance.bar.borderWidth
  // Layout.bottomMargin: -5
  color: "transparent"
  clip: true

  ListView {
    id: list
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.topMargin: Appearance.spacing.p4
    anchors.bottomMargin: Appearance.spacing.p4
    spacing: Appearance.spacing.p2
    // model: AppSearch.list
    model: ScriptModel {
      id: model
      onValuesChanged: list.currentIndex = 0
      values: AppSearch.fuzzyQuery(root.search.text)
    }

    delegate: AppItem { }

    ScrollBar.vertical: ScrollBar {
      id: scroll

      implicitWidth: Appearance.spacing.p0
      contentItem: BorderRectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        color: Appearance.srcery.gray3

        MouseArea {
          id: mouse

          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          hoverEnabled: true
          acceptedButtons: Qt.NoButton
        }
      }
    }
  }
}
