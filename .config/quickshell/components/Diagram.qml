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
import qs

Item {
  id: root
  anchors.centerIn: parent
  property int size: 36
  Rectangle {
    anchors.fill: parent
    border.width: Style.bar.borderWidth
    rotation: 45
    border.color: Style.srcery.gray4
    color: "transparent"

    Quad {
      width: 58
      height: 58
      fillColor: "transparent"
      strokeColor: Style.srcery.gray3
      anchors.top: parent.top
      anchors.right: parent.right
      anchors.rightMargin: Style.spacing.p2
      anchors.topMargin: Style.spacing.p2
      rotation: -90
      topLeft:  Qt.point(1, 0)
      topRight: Qt.point(1, 0)
    }

    Quad {
      width: 58
      height: 58
      rotation: 90
      topLeft:  Qt.point(1, 0)
      topRight: Qt.point(1, 0)
      anchors.bottom: parent.bottom
      anchors.bottomMargin: Style.spacing.p2
      anchors.left: parent.left
      anchors.leftMargin: Style.spacing.p2

    }
  }

  Rectangle {
    anchors.fill: parent
    border.color: GlobalState.launcherOpen ? Style.srcery.hardBlack : Style.srcery.black
    color: "transparent"
    border.width: root.size / 2

    Behavior on color {
      ColorAnimation {
        duration: 300
        easing.type: Easing.OutQuad
      }
    }

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
      Layout.preferredWidth: parent.width - Style.spacing.p2 * 2
      Layout.preferredHeight: 15

      Rectangle {
        id: tldot
        radius: artist.dotSize / 2
        color: Style.srcery.gray6
        width: artist.dotSize
        height: artist.dotSize
        anchors.verticalCenter: parent.verticalCenter
        x: AudioData.activePlayer?.isPlaying
          ? (artistText.x - width - Style.spacing.p2)
          : 0
        Behavior on x {
          NumberAnimation {
            duration: Style.durations.normal
            easing.type: Easing.InOutCubic
          }
        }
      }

      Text {
        id: artistText
        anchors.centerIn: parent
        width: {
          if (text.length > 38) {
            return parent.width - artist.dotSize * 2 - Style.spacing.p2 * 2
          }
        }
        elide: Text.ElideRight
        text: AudioData.activePlayer?.trackArtist ?? ""
        Behavior on opacity {
          NumberAnimation {
            duration: Style.durations.normal
            easing.type: Easing.InOutCubic
          }
        }
        opacity: AudioData.activePlayer?.isPlaying ? 1 : 0
        font {
          family: Style.font.light
          pointSize: Style.font.small
        }
        color: Style.srcery.brightBlack
      }

      Rectangle {
        id: trdot
        radius: artist.dotSize / 2
        color: Style.srcery.gray6
        width: artist.dotSize
        height: artist.dotSize
        anchors.verticalCenter: parent.verticalCenter
        x: AudioData.activePlayer?.isPlaying
          ? (artistText.x + artistText.width + Style.spacing.p2)
          : (parent.width - width)
        Behavior on x {
          NumberAnimation {
            duration: Style.durations.normal
            easing.type: Easing.InOutCubic
          }
        }
      }
    }

    Item {
      Layout.preferredWidth: parent.width - Style.spacing.p2 * 2
      Layout.preferredHeight: 15

      Rectangle {
        id: bldot
        radius: artist.dotSize / 2
        color: Style.srcery.gray6
        width: artist.dotSize
        height: artist.dotSize
        anchors.verticalCenter: parent.verticalCenter
        x: AudioData.activePlayer?.isPlaying
          ? (trackText.x - width - Style.spacing.p2)
          : 0
        Behavior on x {
          NumberAnimation {
            duration: Style.durations.normal
            easing.type: Easing.InOutCubic
          }
        }
      }

      Text {
        id: trackText
        anchors.centerIn: parent
        width: {
          if (text.length > 38) {
            return parent.width - artist.dotSize * 2 - Style.spacing.p2 * 2
          }
        }
        elide: Text.ElideRight
        text: AudioData.activePlayer?.trackTitle ?? ""
        Behavior on opacity {
          NumberAnimation {
            duration: Style.durations.normal
            easing.type: Easing.InOutCubic
          }
        }
        opacity: AudioData.activePlayer?.isPlaying ? 1 : 0
        font {
          family: Style.font.light
          pointSize: Style.font.small
        }
        color: Style.srcery.brightBlack
      }

      Rectangle {
        id: brdot
        radius: artist.dotSize / 2
        color: Style.srcery.gray6
        width: artist.dotSize
        height: artist.dotSize
        anchors.verticalCenter: parent.verticalCenter
        x: AudioData.activePlayer?.isPlaying
          ? (trackText.x + trackText.width + Style.spacing.p2)
          : (parent.width - width)
        Behavior on x {
          NumberAnimation {
            duration: Style.durations.normal
            easing.type: Easing.InOutCubic
          }
        }
      }
    }
  }
  Rectangle {
    anchors.centerIn: parent
    border.color: Style.srcery.gray4
    border.width: Style.bar.borderWidth
    implicitWidth: parent.implicitWidth - root.size
    implicitHeight: parent.implicitHeight - root.size
    color: "transparent"
  }

  Rectangle {
    anchors.fill: parent
    border.width: Style.bar.borderWidth
    border.color: Style.srcery.gray4
    color: "transparent"
  }
}
