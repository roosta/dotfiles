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
    RowLayout {
      spacing: Appearance.spacing.p2
      Rectangle {
        radius: artist.dotSize / 2
        color: Appearance.srcery.gray6
        implicitWidth: artist.dotSize
        implicitHeight: artist.dotSize
      }
      Text {
        text: AudioData.activePlayer.trackArtist
        font {
          family: Appearance.font.light
          pointSize: Appearance.font.small
        }
        color: Appearance.srcery.white
      }

      Rectangle {
        radius: artist.dotSize / 2
        color: Appearance.srcery.gray6
        implicitWidth: artist.dotSize
        implicitHeight: artist.dotSize
      }
    }
    RowLayout {
      spacing: Appearance.spacing.p2
      Rectangle {
        radius: artist.dotSize / 2
        color: Appearance.srcery.gray6
        implicitWidth: artist.dotSize
        implicitHeight: artist.dotSize
      }
      Text {
        text: AudioData.activePlayer.trackTitle
        font {
          family: Appearance.font.light
          pointSize: Appearance.font.small
        }
        color: Appearance.srcery.white
      }

      Rectangle {
        radius: artist.dotSize / 2
        color: Appearance.srcery.gray6
        implicitWidth: artist.dotSize
        implicitHeight: artist.dotSize
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
