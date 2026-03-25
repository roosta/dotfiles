// ┌────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█▀▄░▀█▀░█▀█░█▀▀░█▀▄░█▀█░█▄█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█░█░░█░░█▀█░█░█░█▀▄░█▀█░█░█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀▀░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀░▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>           ├┤
// ││ Repo    : https://github.com/roosta/dotfiles     ││
// ││ Site    : https://www.roosta.sh                  ││
// ├┤ License : GNU General Public License v3          ├┤
// ┆└──────────────────────────────────────────────────┘┆
pragma ComponentBehavior: Bound
import QtQuick
import qs.config
import qs.services
import QtQuick.Layouts

Item {
  id: root
  anchors.centerIn: parent
  property int size: 36
  Rectangle {
    anchors.fill: parent
    border.width: Appearance.bar.borderWidth
    rotation: 45
    border.color: Appearance.srcery.gray4
    color: "transparent"
  }

  Rectangle {
    anchors.fill: parent
    border.color: Appearance.srcery.black
    color: "transparent"
    border.width: root.size / 2
  }

  FlexboxLayout {
    direction: FlexboxLayout.Column
    justifyContent: FlexboxLayout.JustifySpaceBetween
    anchors.fill: parent
    anchors.topMargin: 2
    alignItems: FlexboxLayout.AlignCenter
    anchors.bottomMargin: 2
    property int dotSize: 5
    id: artist
    Item {
      Layout.preferredWidth: parent.width - Appearance.spacing.p2 * 2
      Layout.preferredHeight: 15

      Rectangle {
        id: tldot
        radius: artist.dotSize / 2
        color: Appearance.srcery.gray6
        width: artist.dotSize
        height: artist.dotSize
        anchors.verticalCenter: parent.verticalCenter
        x: AudioData.activePlayer?.isPlaying
          ? (artistText.x - width - Appearance.spacing.p2)
          : 0
        Behavior on x {
          NumberAnimation {
            duration: Appearance.durations.normal
            easing.type: Easing.InOutCubic
          }
        }
      }

      Text {
        id: artistText
        anchors.centerIn: parent
        text: AudioData.activePlayer.trackArtist ?? ""
        Behavior on opacity {
          NumberAnimation {
            duration: Appearance.durations.normal
            easing.type: Easing.InOutCubic
          }
        }
        opacity: AudioData.activePlayer?.isPlaying ? 1 : 0
        font {
          family: Appearance.font.light
          pointSize: Appearance.font.small
        }
        color: Appearance.srcery.white
      }

      Rectangle {
        id: trdot
        radius: artist.dotSize / 2
        color: Appearance.srcery.gray6
        width: artist.dotSize
        height: artist.dotSize
        anchors.verticalCenter: parent.verticalCenter
        x: AudioData.activePlayer?.isPlaying
          ? (artistText.x + artistText.width + Appearance.spacing.p2)
          : (parent.width - width)
        Behavior on x {
          NumberAnimation {
            duration: Appearance.durations.normal
            easing.type: Easing.InOutCubic
          }
        }
      }
    }

    Item {
      Layout.preferredWidth: parent.width - Appearance.spacing.p2 * 2
      Layout.preferredHeight: 15

      Rectangle {
        id: bldot
        radius: artist.dotSize / 2
        color: Appearance.srcery.gray6
        width: artist.dotSize
        height: artist.dotSize
        anchors.verticalCenter: parent.verticalCenter
        x: AudioData.activePlayer?.isPlaying
          ? (trackText.x - width - Appearance.spacing.p2)
          : 0
        Behavior on x {
          NumberAnimation {
            duration: Appearance.durations.normal
            easing.type: Easing.InOutCubic
          }
        }
      }

      Text {
        id: trackText
        anchors.centerIn: parent
        text: AudioData.activePlayer.trackTitle ?? ""
        Behavior on opacity {
          NumberAnimation {
            duration: Appearance.durations.normal
            easing.type: Easing.InOutCubic
          }
        }
        opacity: AudioData.activePlayer?.isPlaying ? 1 : 0
        font {
          family: Appearance.font.light
          pointSize: Appearance.font.small
        }
        color: Appearance.srcery.white
      }

      Rectangle {
        id: brdot
        radius: artist.dotSize / 2
        color: Appearance.srcery.gray6
        width: artist.dotSize
        height: artist.dotSize
        anchors.verticalCenter: parent.verticalCenter
        x: AudioData.activePlayer?.isPlaying
          ? (trackText.x + trackText.width + Appearance.spacing.p2)
          : (parent.width - width)
        Behavior on x {
          NumberAnimation {
            duration: Appearance.durations.normal
            easing.type: Easing.InOutCubic
          }
        }
      }
    }
  }
  Rectangle {
    anchors.centerIn: parent
    border.color: Appearance.srcery.gray4
    border.width: Appearance.bar.borderWidth
    implicitWidth: parent.implicitWidth - root.size
    implicitHeight: parent.implicitHeight - root.size
    color: "transparent"
  }

  Rectangle {
    anchors.fill: parent
    border.width: Appearance.bar.borderWidth
    border.color: Appearance.srcery.gray4
    color: "transparent"
  }
}
