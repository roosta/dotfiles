pragma ComponentBehavior: Bound
import Quickshell
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import qs.config
import qs.components
import qs.services
import qs.utils
import qs

Item {
  id: root
  required property string monitorId
  anchors.fill: parent

  Connections {
    target: GlobalState

    function onLauncherOpenChanged() {
      if (GlobalState.launcherOpen && GlobalState.activeMonitorId === field.monitorId) {
        field.forceActiveFocus();
      } else {
        field.text = ""
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
        highlightFollowsCurrentItem: true
        delegate: AppItem { }
        highlight: Rectangle {
          color: "transparent"
          border.color: Appearance.srcery.gray3
          border.width: Appearance.bar.borderWidth
        }
        model: ScriptModel {
          id: model
          onValuesChanged: list.currentIndex = 0
          values: AppSearch.fuzzyQuery(field.text)
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
        add: Transition {
          NumberAnimation {
            properties: "opacity,scale"
            easing.type: Easing.InCubic
            duration: Appearance.durations.normal
            from: 0
            to: 1
          }
        }

        move: Transition {
          NumberAnimation {
            properties: "y"
            easing.type: Easing.InOutCubic
            duration: Appearance.durations.normal
          }

          NumberAnimation {
            properties: "opacity,scale"
            easing.type: Easing.InOutCubic
            duration: Appearance.durations.normal
            to: 1
          }
        }
        remove: Transition {
          NumberAnimation {
            properties: "opacity,scale"
            easing.type: Easing.OutCubic
            duration: Appearance.durations.normal
            from: 0
            to: 1
          }
        }

        addDisplaced: Transition {
          NumberAnimation {
            property: "y"
            easing.type: Easing.InOutCubic
            duration: Appearance.durations.small
          }
          NumberAnimation {
            properties: "opacity,scale"
            to: 1
            easing.type: Easing.InOutCubic
            duration: Appearance.durations.normal
          }
        }

        displaced: Transition {
          NumberAnimation {
            property: "y"
            easing.type: Easing.InOutCubic
            duration: Appearance.durations.normal
          }
          NumberAnimation {
            properties: "opacity,scale"
            to: 1

            easing.type: Easing.InOutCubic
            duration: Appearance.durations.normal
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
