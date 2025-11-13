pragma ComponentBehavior: Bound
import qs.config
import qs.services
import qs.components
import QtQuick
import QtQuick.Layouts

import QtQuick.Controls

BorderRectangle {
  id: root
  color: Appearance.srcery.black
  borderColor: Appearance.srcery.gray3
  borderWidth: Appearance.bar.borderWidth
  Layout.topMargin: Appearance.bar.borderWidth
  visible: Alerts.hasAlerts

  required property string monitorId

  property int iconSize: 16 * Config.scale
  implicitWidth: layout.implicitWidth + Appearance.spacing.p1 * 2
  implicitHeight: Appearance.bar.height - Appearance.spacing.p3

  Behavior on implicitWidth {
    NumberAnimation {
      duration: Appearance.durations.small
      easing.type: Easing.InOutCubic
    }
  }
  RowLayout {
    id: layout
    spacing: Appearance.spacing.p1
    anchors.fill: parent
    anchors.leftMargin: Appearance.spacing.p1
    anchors.rightMargin: Appearance.spacing.p1

    Rectangle {
      id: failedServices
      visible: false
      color: "transparent"
      Layout.preferredWidth: Appearance.font.size4
      Layout.preferredHeight: Appearance.font.size4
      Text {
        text: ""
        color: Appearance.srcery.brightOrange
        anchors.centerIn: parent
        font {
          family: Appearance.font.light
          pixelSize: Appearance.font.size4
        }
      }
    }
    Rectangle {
      id: audioIn
      visible: false
      color: "transparent"
      Layout.preferredWidth: Appearance.font.size4
      Layout.preferredHeight: Appearance.font.size4
      Text {
        text: ""
        anchors.centerIn: parent
        color: Appearance.srcery.brightYellow
        font {
          family: Appearance.font.light
          pixelSize: Appearance.font.size4
        }
      }
    }
    Rectangle {
      id: screenshare
      color: "transparent"
      visible: false
      Layout.preferredWidth: Appearance.font.size4
      Layout.preferredHeight: Appearance.font.size4
      Text {
        text: "󱎴"
        anchors.centerIn: parent
        color: Appearance.srcery.brightRed
        font {
          family: Appearance.font.light
          pixelSize: Appearance.font.size4
        }
      }
    }
  }
}
