import qs.services
import qs.config
import qs.utils
import qs.components
import qs
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
    BorderRectangle {
      implicitWidth: Appearance.bar.height
      implicitHeight: Appearance.bar.height - Appearance.bar.borderWidth
      Layout.topMargin: Appearance.bar.borderWidth
      color: Appearance.srcery.black
      // rightBorder: Appearance.bar.borderWidth
      leftBorder: Appearance.bar.borderWidth
      borderColor: Appearance.srcery.gray3
      IconImage {
        id: windowIcon
        anchors.centerIn: parent
        source: GlobalState.windowStatus.icon
        implicitSize: parent.height - Appearance.spacing.p3
      }
    }
    ColumnLayout {
      id: colLayout
      Layout.fillWidth: true
      spacing: -4
      Text {

        font {
          family: Appearance.font.light
          pointSize: Appearance.font.normal
        }

        color: Appearance.srcery.brightWhite
        text: GlobalState.windowStatus.title
      }
      Text {
        id: window
        elide: Text.ElideRight
        Layout.fillWidth: true
        Layout.rightMargin: Appearance.spacing.p5
        font {
          family: Appearance.font.light
          pointSize: Appearance.font.small
        }

        color: Appearance.srcery.white
        text: GlobalState.windowStatus.desc
      }
    }
  }
}
