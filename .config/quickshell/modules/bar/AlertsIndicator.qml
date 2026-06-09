// ┌────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█▀█░█░░░█▀▀░█▀▄░▀█▀░█▀▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█▀█░█░░░█▀▀░█▀▄░░█░░▀▀█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀░▀░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>       ├┤
// ││ Repo    : https://github.com/roosta/dotfiles ││
// ││ Site    : https://www.roosta.sh              ││
// ├┤ License : GNU General Public License v3      ├┤
// ┆└──────────────────────────────────────────────┘┆

pragma ComponentBehavior: Bound
import qs.config
import qs.services
import qs.components
import QtQuick
import QtQuick.Layouts

import QtQuick.Controls

BorderRect {
  id: root
  color: Style.srcery.black
  borderColor: Style.srcery.gray3
  borderWidth: Style.bar.borderWidth
  Layout.topMargin: Style.bar.borderWidth
  visible: Alerts.hasAlerts

  required property string monitorId

  property int iconSize: 16 * Config.scale
  implicitWidth: layout.implicitWidth + Style.spacing.p1 * 2
  implicitHeight: Style.bar.height - Style.spacing.p3
  MouseArea {
    id: mouseArea
    hoverEnabled: true
    anchors.fill: parent
  }
  Behavior on implicitWidth {
    NumberAnimation {
      duration: Style.durations.small
      easing.type: Easing.InOutCubic
    }
  }
  states: [
    State {
      name: "hovered"
      when: mouseArea.containsMouse && !mouseArea.pressed
      PropertyChanges { root.borderColor: Style.srcery.gray4 }
      PropertyChanges { mouseArea.cursorShape: Qt.PointingHandCursor }
    },
    State {
      name: "pressed"
      when: mouseArea.pressed && mouseArea.containsMouse
      PropertyChanges { root.borderColor: Style.srcery.gray6 }
      PropertyChanges { mouseArea.cursorShape: Qt.PointingHandCursor }
    }
  ]
  RowLayout {
    id: layout
    spacing: Style.spacing.p1
    anchors.fill: parent
    anchors.leftMargin: Style.spacing.p1
    anchors.rightMargin: Style.spacing.p1

    Rectangle {
      id: failedServices
      visible: false
      color: "transparent"
      Layout.preferredWidth: Style.font.size3
      Layout.preferredHeight: Style.font.size3
      Text {
        text: ""
        color: Style.srcery.brightOrange
        anchors.centerIn: parent
        font {
          family: Style.font.light
          pixelSize: Style.font.size3
        }
      }
    }
    Rectangle {
      id: audioIn
      visible: Alerts.audioIn
      color: "transparent"
      Layout.preferredWidth: Style.font.size3
      Layout.preferredHeight: Style.font.size3
      Text {
        text: ""
        anchors.centerIn: parent
        color: Style.srcery.brightYellow
        font {
          family: Style.font.light
          pixelSize: Style.font.size3
        }
      }
    }
    Rectangle {
      id: audioOut
      visible: false
      color: "transparent"
      Layout.preferredWidth: Style.font.size3
      Layout.preferredHeight: Style.font.size3
      Text {
        text: "󰓃"
        anchors.centerIn: parent
        color: Style.srcery.white
        font {
          family: Style.font.light
          pixelSize: Style.font.size3
        }
      }
    }
    Rectangle {
      id: screenshare
      color: "transparent"
      visible: Alerts.videoIn
      Layout.preferredWidth: Style.font.size3
      Layout.preferredHeight: Style.font.size3
      Text {
        text: "󱎴"
        anchors.centerIn: parent
        color: Style.srcery.brightRed
        font {
          family: Style.font.light
          pixelSize: Style.font.size3
        }
      }
    }
    Rectangle {
      id: cpu
      color: "transparent"
      visible: Alerts.cpuUsage
      Layout.preferredWidth: Style.font.size3
      Layout.preferredHeight: Style.font.size3
      ToolTip {
        id: control
        font: Style.font.main
        delay: 600
        text: ResourceUsage.cpuTooltip
        visible: mouseArea.containsMouse
        contentItem: Text {
          text: control.text
          font: control.font
          color: Style.srcery.brightWhite
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
        background: BorderRect {
          color: Style.srcery.gray1
        }
      }
      Text {
        text: ""
        anchors.centerIn: parent
        color: Style.srcery.yellow
        font {
          family: Style.font.light
          pixelSize: Style.font.size3
        }
      }
    }
  }
}
