// ┌───────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░░█▀█░█░█░█▀▄░▀█▀░█▀█░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░░█▀█░█░█░█░█░░█░░█░█░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀───────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>      ├┤
// ││ Repo    : https://github.com/roosta/dotfiles││
// ││ Site    : https://www.roosta.sh             ││
// ├┤ License : GNU General Public License v3     ├┤
// ┆└─────────────────────────────────────────────┘┆

pragma ComponentBehavior: Bound
import qs.config
import qs.services
import qs.components
import qs
import QtQuick
import QtQuick.Layouts

import QtQuick.Controls

ExpandingButton {
  id: root

  property bool muted: AudioData.ready && AudioData.sink.audio.muted
  property string mutedIcon: ""

  function getSinkIcon(sink) {
    if (sink) {
      const obj = Config.outputs.find(o => o.sink === sink.name);
      if (obj) { return obj.icon }
    } else {
      return ""
    }
  }
  buttonLabel: muted ? mutedIcon : getSinkIcon(AudioData.sink)

  Connections {
    target: AudioData
    function onVolumeChanged() {
      if (!timer.running && AudioData.ready) {
        timer.running = true
        root.active = true
      }
    }
  }

  Timer {
    id: timer
    running: false
    interval: 1000 * 10
    onTriggered: {
      root.active = false
    }
  }

  property var openAudioMenu: () => {
    const i = Config.outputs.findIndex(o => o.sink === AudioData.sink.name)
    GlobalState.openLauncher({
      id: root.monitorId,
      mode: "audio",
      direction: Qt.RightToLeft,
      index: i > -1 ? i : 0
    })
  }

  onRightClick: openAudioMenu

  BorderRect {
    id: srcBtn
    visible: root.active
    implicitWidth: srcBtnText.implicitWidth
    implicitHeight: srcBtnText.implicitHeight
    color: Style.srcery.black
    states: [
      State {
        name: "hovered"
        when: srcMouse.containsMouse
        PropertyChanges { srcBtnText.color: Style.srcery.brightWhite }
        PropertyChanges { srcMouse.cursorShape: Qt.PointingHandCursor }
      }
    ]
    MouseArea {
      id: srcMouse
      hoverEnabled: true
      anchors.fill: parent
      onClicked: root.openAudioMenu()
    }

    transitions: [
      Transition {
        ColorAnimation {
          duration: Style.durations.small
          easing.type: Easing.OutQuad
        }
      }
    ]
    Text {
      anchors.centerIn: parent
      color: Style.srcery.white
      id: srcBtnText
      text: root.buttonLabel
      font {
        family: Style.font.light
        pixelSize: Style.font.size3
      }
    }
  }
  BorderRect {
    id: inputBtn
    visible: root.active
    implicitWidth: inputBtnText.implicitWidth
    implicitHeight: inputBtnText.implicitHeight
    color: Style.srcery.black
    Text {
      anchors.centerIn: parent
      color: Style.srcery.white
      id: inputBtnText
      text: {
        if (AudioData.source?.audio?.muted) {
          return "󰍭"
        } else {
          return ""
        }
      }
      font {
        family: Style.font.light
        pixelSize: Style.font.size3
      }
    }
  }

  Slider {
    id: volumeSlider
    visible: root.active
    implicitWidth: Style.bar.sliderWidth
    from: 0.0
    value: AudioData.sink?.audio.volume ?? 0
    onMoved: AudioData.sink.audio.volume = value
    to: 1.0
    HoverHandler {
      cursorShape: Qt.PointingHandCursor
    }
    background: Rectangle {
      x: volumeSlider.leftPadding
      y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
      implicitWidth: 200
      implicitHeight: Style.spacing.p3
      width: volumeSlider.availableWidth
      height: implicitHeight
      color: Style.srcery.gray3

      Rectangle {
        width: volumeSlider.visualPosition * parent.width
        height: parent.height
        gradient: Gradient {
          orientation: Gradient.Horizontal
          GradientStop { position: 1; color: Style.srcery.magenta }
          GradientStop { position: 0; color: Style.srcery.blue }
        }
      }
    }
    handle: Rectangle {
      x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
      y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
      implicitWidth: Style.spacing.p4
      implicitHeight: Style.spacing.p3
      radius: 0
      color: volumeSlider.pressed ? Style.srcery.brightMagenta : Style.srcery.magenta
      // border.color: Style.srcery.magenta
    }
  }
}
