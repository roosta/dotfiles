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
      const obj = Config.outputs.find(o => o.sink == sink.name);
      if (obj) { return obj.icon }
    } else {
      return ""
    }
  }
  buttonLabel: muted ? mutedIcon : getSinkIcon(AudioData.sink)

  BorderRect {
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
        GlobalState.openLauncher(root.monitorId, "audio", Qt.RightToLeft)
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
      text: root.buttonLabel
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
}
