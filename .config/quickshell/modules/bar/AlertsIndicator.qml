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
    cursorShape: Qt.PointingHandCursor
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
    },
    State {
      name: "pressed"
      when: mouseArea.pressed && mouseArea.containsMouse
      PropertyChanges { root.borderColor: Style.srcery.gray6 }
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
      MouseArea {
        id: audioArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

      }
      ToolTip {
        id: audioControl
        font.family: Style.font.main
        delay: 600
        text: Alerts.audioInTooltip
        visible: audioArea.containsMouse
        contentItem: Text {
          text: audioControl.text
          font: audioControl.font
          color: Style.srcery.brightWhite
        }

        background: BorderRect {
          color: Style.srcery.gray1
        }
      }
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
      MouseArea {
        id: cpuArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

      }
      ToolTip {
        id: cpuControl
        font.family: Style.font.main
        delay: 600
        text: ResourceUsage.cpuTooltip
        visible: cpuArea.containsMouse
        contentItem: Text {
          text: cpuControl.text
          font: cpuControl.font
          color: Style.srcery.brightWhite
        }

        Timer {
          interval: 1000
          running: cpuControl.visible
          repeat: cpuControl.visible
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
