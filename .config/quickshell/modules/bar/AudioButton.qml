pragma ComponentBehavior: Bound
import qs.config
import qs.services
import qs.components
import qs
import QtQuick
import QtQuick.Layouts

import QtQuick.Controls

BorderRectangle {
  id: root
  color: Appearance.srcery.black
  borderColor: Appearance.srcery.gray3
  borderWidth: Appearance.bar.borderWidth
  Layout.topMargin: Appearance.bar.borderWidth

  required property string monitorId

  implicitWidth: {
    if (root.active) {
      return layout.implicitWidth + Appearance.spacing.p3
    } else {
      return layout.implicitWidth
    }
  }

  implicitHeight: Appearance.bar.height - Appearance.spacing.p3
  property bool active: false

  onActiveChanged: {
    if (root.active) {
      timer.restart()
    }
  }

  // Automatically close after 30 seconds
  // TODO: Should be open when menu is visible, or inside mouse area
  Timer {
    id: timer
    interval: 1000 * 30
    onTriggered: {
      root.active = false
    }
  }
  Behavior on implicitWidth {
    NumberAnimation {
      duration: Appearance.durations.small
      easing.type: Easing.InOutCubic
    }
  }
  states: [
    State {
      name: "default"
      when: !root.active && !button.hovered
      PropertyChanges { indicator.text: Config.getSinkIcon(Audio.sink) }
      PropertyChanges { buttonBg.borderColor: Appearance.srcery.gray3 }
    },
    State {
      name: "hovered"
      when: !root.active && button.hovered
      PropertyChanges { indicator.text: Config.getSinkIcon(Audio.sink) }
      PropertyChanges { buttonBg.borderColor: Appearance.srcery.gray6 }
    },
    State {
      name: "active"
      when: root.active && !button.hovered
      PropertyChanges { indicator.text: "❯" }
      PropertyChanges { buttonBg.borderColor: Appearance.srcery.gray3 }
    },
    State {
      name: "activeHovered"
      when: root.active && button.hovered
      PropertyChanges { root.borderColor: Appearance.srcery.gray6 }
      PropertyChanges { indicator.text: "❯" }
      PropertyChanges { buttonBg.borderColor: Appearance.srcery.gray6 }
    }
  ]

  RowLayout {
    id: layout
    spacing: Appearance.spacing.p3
    Button {
      id: button
      implicitHeight: root.height
      implicitWidth: root.height
      onPressed: {
        root.active = !root.active
      }

      HoverHandler {
        id: hover
        cursorShape: Qt.PointingHandCursor
      }
      background: BorderRectangle {
        id: buttonBg
        color: Appearance.srcery.black
        borderWidth: Appearance.bar.borderWidth
        borderColor: Appearance.srcery.gray3
        Text {
          anchors.centerIn: parent
          id: indicator
          color: Appearance.srcery.white
          font {
            family: Appearance.font.light
            pixelSize: Appearance.font.size3
          }
        }
      }
    }
    BorderRectangle {
      id: srcBtn
      visible: root.active
      implicitWidth: srcBtnText.implicitWidth
      implicitHeight: srcBtnText.implicitHeight
      color: Appearance.srcery.black
      states: [
        State {
          name: "hovered"
          when: srcMouse.containsMouse
          PropertyChanges { srcBtnText.color: Appearance.srcery.brightWhite }
          PropertyChanges { srcMouse.cursorShape: Qt.PointingHandCursor }
        }
      ]
      MouseArea {
        id: srcMouse
        hoverEnabled: true
        anchors.fill: parent
        onClicked: {
          GlobalState.openLauncher(root.monitorId, "audio")
        }
      }

      transitions: [
        Transition {
          ColorAnimation { 
            duration: Appearance.durations.small
            easing.type: Easing.OutQuad 
          }
        }
      ]
      Text {
        anchors.centerIn: parent
        color: Appearance.srcery.white
        id: srcBtnText
        text: Config.getSinkIcon(Audio.sink)
        font {
          family: Appearance.font.light
          pixelSize: Appearance.font.size3
        }
      }

    }
    Slider {
      id: volumeSlider
      visible: root.active
      implicitWidth: Appearance.bar.sliderWidth
      from: 0.0
      value: Audio.sink?.audio.volume ?? 0
      onMoved: Audio.sink.audio.volume = value
      to: 1.0
      HoverHandler {
        cursorShape: Qt.PointingHandCursor
      }
      background: Rectangle {
        x: volumeSlider.leftPadding
        y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: Appearance.spacing.p3
        width: volumeSlider.availableWidth
        height: implicitHeight
        color: Appearance.srcery.gray3

        Rectangle {
          width: volumeSlider.visualPosition * parent.width
          height: parent.height
          gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 1; color: Appearance.srcery.magenta }
            GradientStop { position: 0; color: Appearance.srcery.blue }
          }
        }
      }
      handle: Rectangle {
        x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
        y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
        implicitWidth: Appearance.spacing.p4
        implicitHeight: Appearance.spacing.p3
        radius: 0
        color: volumeSlider.pressed ? Appearance.srcery.brightMagenta : Appearance.srcery.magenta
        // border.color: Appearance.srcery.magenta
      }
    }
    // Repeater {
    //   id: items
    //   model: root.active ? SystemTray.items : null
    //   visible: root.active
    //   TrayItem {}
    // }
  }
}
