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

Item {
  id: root
  required property string monitorId
  anchors.fill: parent

  Connections {
    target: GlobalState

    function onLauncherOpenChanged() {
      if (GlobalState.launcherOpen && GlobalState.activeMonitorId === root.monitorId) {
        field.forceActiveFocus();
        list.highlightMoveDuration = 1000
      } else {
        field.text = ""
        list.highlightMoveDuration = 0
        list.positionViewAtBeginning()
        list.currentIndex = 0
      }
    }
  }

  ColumnLayout {
    anchors.fill: parent
    spacing: 0
    Rectangle {
      id: appList
      Layout.fillWidth: true
      Layout.fillHeight: true

      Layout.margins: Appearance.spacing.p4 + Appearance.bar.borderWidth
      color: "transparent"
      clip: true

      ListView {
        id: list
        anchors.fill: parent
        reuseItems: true
        highlightFollowsCurrentItem: true
        delegate: AppItem { }
        highlight: Rectangle {
          color: "transparent"
          z: 2
          border.color: Appearance.srcery.gray3
          border.width: Appearance.bar.borderWidth
        }
        model: ScriptModel {
          id: listData
          onValuesChanged: {
            list.currentIndex = 0
            list.positionViewAtBeginning()
          }
          values: Apps.fuzzyQuery(field.text)
        }

        ScrollBar.vertical: ScrollBar {
          id: scroll
          padding: 0
          implicitWidth: Appearance.spacing.p1
          contentItem: BorderRectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            borderWidth: 1
            color: Appearance.srcery.black
            borderColor: Appearance.srcery.gray3

            MouseArea {
              id: mouse

              anchors.fill: parent
              cursorShape: Qt.PointingHandCursor
              hoverEnabled: true
              acceptedButtons: Qt.NoButton
            }
          }
        }
        // add: Transition {
        //   NumberAnimation {
        //     properties: "opacity,scale"
        //     easing.type: Easing.InCubic
        //     duration: Appearance.durations.normal
        //     from: 0
        //     to: 1
        //   }
        // }
        //
        // move: Transition {
        //   NumberAnimation {
        //     properties: "y"
        //     easing.type: Easing.InOutCubic
        //     duration: Appearance.durations.normal
        //   }
        //
        //   NumberAnimation {
        //     properties: "opacity,scale"
        //     easing.type: Easing.InOutCubic
        //     duration: Appearance.durations.normal
        //     to: 1
        //   }
        // }
        // remove: Transition {
        //   NumberAnimation {
        //     properties: "opacity,scale"
        //     easing.type: Easing.OutCubic
        //     duration: Appearance.durations.normal
        //     from: 0
        //     to: 1
        //   }
        // }
        //
        // addDisplaced: Transition {
        //   NumberAnimation {
        //     property: "y"
        //     easing.type: Easing.InOutCubic
        //     duration: Appearance.durations.small
        //   }
        //   NumberAnimation {
        //     properties: "opacity,scale"
        //     to: 1
        //     easing.type: Easing.InOutCubic
        //     duration: Appearance.durations.normal
        //   }
        // }
        //
        // displaced: Transition {
        //   NumberAnimation {
        //     property: "y"
        //     easing.type: Easing.InOutCubic
        //     duration: Appearance.durations.normal
        //   }
        //   NumberAnimation {
        //     properties: "opacity,scale"
        //     to: 1
        //
        //     easing.type: Easing.InOutCubic
        //     duration: Appearance.durations.normal
        //   }
        // }
      }
    }
    BorderRectangle {
      implicitHeight: Appearance.launcher.itemHeight + Appearance.spacing.p2
      Layout.fillWidth: true
      color: Appearance.srcery.black
      Layout.leftMargin: Appearance.bar.borderWidth
      Layout.rightMargin: Appearance.bar.borderWidth

      topBorder: 1
      borderColor: Appearance.srcery.gray3
      RowLayout {
        anchors.fill: parent

        Repeater {
          model: Config.favorites
          Button {
            id: fav

            required property string modelData
            property DesktopEntry entry: Apps.getEntry(modelData)
            Layout.alignment: Qt.AlignHCenter
            Layout.margins: Appearance.spacing.p2
            Layout.fillHeight: true
            Layout.preferredWidth: favicon.width + Appearance.spacing.p2 * 2
            // Layout.margins: Appearance.spacing.p2
            //


            ToolTip {
              id: control
              font: Appearance.font.main
              delay: 600
              timeout: 4000
              text: fav.entry?.name
              visible: fav.hovered
              contentItem: Text {
                text: control.text
                font: control.font
                color: Appearance.srcery.brightWhite
              }

              background: Rectangle {
                color: Appearance.srcery.gray1
              }
            }
            onPressed: {
              Apps.launch(entry)
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
                source: Apps.getEntryIcon(fav.entry)
                // implicitHeight: parent.height / 2
                implicitWidth: parent.height - Appearance.spacing.p2 * 2
                implicitHeight: parent.height - Appearance.spacing.p2 * 2
                // implicitWidth: favicon.height
                // Layout.fillHeight: true
              }
            }

            states: [
              State {
                name: "pressed"
                when: fav.pressed
                PropertyChanges { bg.color: Appearance.srcery.gray2 }
              },
              State {
                name: "hovered"
                when: fav.hovered && !fav.pressed
                PropertyChanges { bg.color: Appearance.srcery.gray1 }
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
    BorderRectangle {
      Layout.alignment: Qt.AlignHCenter
      Layout.fillWidth: true
      color: Appearance.srcery.black
      topBorder: Appearance.bar.borderWidth
      Layout.leftMargin: Appearance.bar.borderWidth
      Layout.rightMargin: Appearance.bar.borderWidth
      Layout.bottomMargin: Appearance.bar.borderWidth
      borderColor: Appearance.srcery.gray3
      Layout.preferredHeight: field.implicitHeight + Appearance.spacing.p4 * 2
      TextField {
        color: Appearance.srcery.brightWhite
        id: field
        anchors.centerIn: parent
        anchors.margins: Appearance.spacing.p4
        // Layout.alignment: Qt.AlignHCenter
        renderType: TextField.NativeRendering
        cursorVisible: !readOnly
        placeholderTextColor: Appearance.srcery.gray3
        font.family: Appearance.font.light
        font.pointSize: Appearance.font.size1
        implicitWidth: parent.width - Appearance.spacing.p4 * 2 + Appearance.bar.borderWidth * 2
        placeholderText: " Search..."
        background: Rectangle {
          color: "transparent"
          border.color: Appearance.srcery.gray3
        }

        Keys.onEscapePressed: GlobalState.closeLauncher()
        Keys.onUpPressed: list.decrementCurrentIndex()
        Keys.onDownPressed: list.incrementCurrentIndex()
        Component.onCompleted: forceActiveFocus()
        onAccepted: {
          const currentItem = list?.currentItem;
          if (currentItem) {
            Apps.launch(currentItem.modelData);
            GlobalState.closeLauncher()
          }
        }

        // https://github.com/caelestia-dots/shell/blob/fe4ebb79b6162d7e5e4e9a00d8a39ff10876fb8c/modules/launcher/Content.qml#L109
        Keys.onPressed: event => {
          if (event.modifiers & Qt.ControlModifier) {
            if (event.key === Qt.Key_J) {
              list.incrementCurrentIndex();
              event.accepted = true;
            } else if (event.key === Qt.Key_K) {
              list.decrementCurrentIndex();
              event.accepted = true;
            }
          } else if (event.key === Qt.Key_Tab) {
            list.incrementCurrentIndex();
            event.accepted = true;
          } else if (event.key === Qt.Key_Backtab || (event.key === Qt.Key_Tab && (event.modifiers & Qt.ShiftModifier))) {
            list.decrementCurrentIndex();
            event.accepted = true;
          }
        }
        cursorDelegate: Rectangle {
          id: cursor
          property bool disableBlink
          color: Appearance.srcery.brightWhite
          implicitWidth: Appearance.spacing.p1

          Connections {
            target: field

            function onCursorPositionChanged(): void {
              if (field.activeFocus && field.cursorVisible) {
                cursor.opacity = 1;
                cursor.disableBlink = true;
                enableBlink.restart();
              }
            }
          }

          Timer {
            running: field.activeFocus && field.cursorVisible && !cursor.disableBlink
            repeat: true
            triggeredOnStart: true
            interval: 500
            onTriggered: parent.opacity = parent.opacity === 1 ? 0 : 1
          }
          Binding {
            when: !field.activeFocus || !field.cursorVisible
            cursor.opacity: 0
          }
          Timer {
            id: enableBlink

            interval: 100
            onTriggered: cursor.disableBlink = false
          }

          Behavior on opacity {
            NumberAnimation {
              duration: 200
              easing.type: Easing.InOutCubic
            }
          }

        }

        Behavior on color {
          ColorAnimation { 
            duration: 50
            easing.type: Easing.OutQuad 
          }
        }
        Behavior on placeholderTextColor {
          ColorAnimation { 
            duration: 50
            easing.type: Easing.OutQuad 
          }
        }

      }
    }
  }
}
