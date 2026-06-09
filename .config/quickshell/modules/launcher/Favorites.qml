// ┌────────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█▀▀░█▀█░█░█░█▀█░█▀▄░▀█▀░▀█▀░█▀▀░█▀▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█▀▀░█▀█░▀▄▀░█░█░█▀▄░░█░░░█░░█▀▀░▀▀█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀░░░▀░▀░░▀░░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>                   ├┤
// ││ Repo    : https://github.com/roosta/dotfiles             ││
// ││ Site    : https://www.roosta.sh                          ││
// ├┤ License : GNU General Public License v3                  ├┤
// ┆└──────────────────────────────────────────────────────────┘┆

pragma ComponentBehavior: Bound
import Quickshell
import QtQuick.Layouts
import Quickshell.Widgets
import QtQuick.Controls
import QtQuick
import qs.config
import qs.components
import qs.services
// import qs.utils
import qs

BorderRect {
  id: favorites
  implicitHeight: Style.launcher.itemHeight + Style.spacing.p2
  Layout.fillWidth: true
  color: Style.srcery.black
  Layout.leftMargin: Style.bar.borderWidth
  Layout.rightMargin: Style.bar.borderWidth

  topBorder: 1
  borderColor: Style.srcery.gray3
  RowLayout {
    anchors.fill: parent

    Repeater {
      model: Config.favorites
      Button {
        id: fav

        required property string modelData
        property DesktopEntry entry: LauncherData.getEntry(modelData)
        Layout.alignment: Qt.AlignHCenter
        Layout.margins: Style.spacing.p2
        Layout.fillHeight: true
        Layout.preferredWidth: favicon.width + Style.spacing.p2 * 2
        // Layout.margins: Style.spacing.p2
        //


        ToolTip {
          id: control
          font: Style.font.main
          delay: 600
          timeout: 4000
          text: fav.entry?.name
          visible: fav.hovered
          contentItem: Text {
            text: control.text
            font: control.font
            color: Style.srcery.brightWhite
          }

          background: Rectangle {
            color: Style.srcery.gray1
          }
        }
        onPressed: {
          LauncherData.launch(entry)
          GlobalState.closeLauncher()
        }
        HoverHandler {
          id: hover
          cursorShape: Qt.PointingHandCursor
        }
        background: Rectangle {
          id: bg
          color: "transparent"
          radius: 5
          IconImage {
            id: favicon
            anchors.centerIn: parent
            source: Icons.getEntryIcon(fav.entry)
            // implicitHeight: parent.height / 2
            implicitWidth: parent.height - Style.spacing.p2 * 2
            implicitHeight: parent.height - Style.spacing.p2 * 2
            // implicitWidth: favicon.height
            // Layout.fillHeight: true
          }
        }

        states: [
          State {
            name: "pressed"
            when: fav.pressed
            PropertyChanges { bg.color: Style.srcery.gray3 }
          },
          State {
            name: "hovered"
            when: fav.hovered && !fav.pressed
            PropertyChanges { bg.color: Style.srcery.gray1 }
          }
        ]
        transitions: [
          Transition {
            ColorAnimation {
              duration: 50
              easing.type: Easing.OutQuad
            }
          }
        ]

      }
    }
  }
}
