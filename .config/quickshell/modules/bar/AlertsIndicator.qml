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
  MouseArea {
    id: mouseArea
    hoverEnabled: true
    anchors.fill: parent
  }
  Behavior on implicitWidth {
    NumberAnimation {
      duration: Appearance.durations.small
      easing.type: Easing.InOutCubic
    }
  }
  states: [
    State {
      name: "hovered"
      when: mouseArea.containsMouse && !mouseArea.pressed
      PropertyChanges { root.borderColor: Appearance.srcery.gray4 }
      PropertyChanges { mouseArea.cursorShape: Qt.PointingHandCursor }
    },
    State {
      name: "pressed"
      when: mouseArea.pressed && mouseArea.containsMouse
      PropertyChanges { root.borderColor: Appearance.srcery.gray6 }
      PropertyChanges { mouseArea.cursorShape: Qt.PointingHandCursor }
    }
  ]
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
      Layout.preferredWidth: Appearance.font.size3
      Layout.preferredHeight: Appearance.font.size3
      Text {
        text: ""
        color: Appearance.srcery.brightOrange
        anchors.centerIn: parent
        font {
          family: Appearance.font.light
          pixelSize: Appearance.font.size3
        }
      }
    }
    Rectangle {
      id: audioIn
      visible: Alerts.audioIn
      color: "transparent"
      Layout.preferredWidth: Appearance.font.size3
      Layout.preferredHeight: Appearance.font.size3
      Text {
        text: ""
        anchors.centerIn: parent
        color: Appearance.srcery.brightYellow
        font {
          family: Appearance.font.light
          pixelSize: Appearance.font.size3
        }
      }
    }
    Rectangle {
      id: audioOut
      visible: false
      color: "transparent"
      Layout.preferredWidth: Appearance.font.size3
      Layout.preferredHeight: Appearance.font.size3
      Text {
        text: "󰓃"
        anchors.centerIn: parent
        color: Appearance.srcery.white
        font {
          family: Appearance.font.light
          pixelSize: Appearance.font.size3
        }
      }
    }
    Rectangle {
      id: screenshare
      color: "transparent"
      visible: Alerts.videoIn
      Layout.preferredWidth: Appearance.font.size3
      Layout.preferredHeight: Appearance.font.size3
      Text {
        text: "󱎴"
        anchors.centerIn: parent
        color: Appearance.srcery.brightRed
        font {
          family: Appearance.font.light
          pixelSize: Appearance.font.size3
        }
      }
    }
    Rectangle {
      id: cpu
      color: "transparent"
      visible: Alerts.cpuUsage
      Layout.preferredWidth: Appearance.font.size3
      Layout.preferredHeight: Appearance.font.size3
      ToolTip {
        id: control
        font: Appearance.font.main
        delay: 600
        text: ResourceUsage.cpuTooltip
        visible: mouseArea.containsMouse
        contentItem: Text {
          text: control.text
          font: control.font
          color: Appearance.srcery.brightWhite
        }

        Timer {
          id: tpTimer
          interval: 1000
          running: control.visible
          repeat: control.visible
          onTriggered: {
            ResourceUsage.refreshTooltip()
          }
        }
        background: BorderRectangle {
          color: Appearance.srcery.gray1
        }
      }
      Text {
        text: ""
        anchors.centerIn: parent
        color: Appearance.srcery.yellow
        font {
          family: Appearance.font.light
          pixelSize: Appearance.font.size3
        }
      }
    }
  }
}
