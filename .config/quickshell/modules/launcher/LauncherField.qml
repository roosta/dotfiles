pragma ComponentBehavior: Bound
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import qs.config
import qs.components
import qs.services
// import qs.utils
import qs

BorderRectangle {
  id: root
  required property string monitorId
  property alias text: field.text
  Layout.alignment: Qt.AlignHCenter
  Layout.fillWidth: true
  color: Appearance.srcery.black
  topBorder: Appearance.bar.borderWidth
  Layout.leftMargin: Appearance.bar.borderWidth
  Layout.rightMargin: Appearance.bar.borderWidth
  Layout.bottomMargin: Appearance.bar.borderWidth
  borderColor: Appearance.srcery.gray3
  Layout.preferredHeight: field.implicitHeight + Appearance.spacing.p4 * 2
  signal decrementCurrentIndex()
  signal incrementCurrentIndex()
  signal accepted()

  Connections {
    target: GlobalState

    function onLauncherOpenChanged() {
      if (GlobalState.launcherOpen && GlobalState.activeMonitorId === root.monitorId) {
        field.forceActiveFocus();
      } else {
        field.text = ""
      }
    }
  }
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
    Keys.onUpPressed: root.decrementCurrentIndex()
    Keys.onDownPressed: root.incrementCurrentIndex()
    Component.onCompleted: forceActiveFocus()
    onAccepted: root.accepted()

    // https://github.com/caelestia-dots/shell/blob/fe4ebb79b6162d7e5e4e9a00d8a39ff10876fb8c/modules/launcher/Content.qml#L109
    Keys.onPressed: event => {
      if (event.modifiers & Qt.ControlModifier) {
        if (event.key === Qt.Key_J) {
          root.incrementCurrentIndex();
          event.accepted = true;
        } else if (event.key === Qt.Key_K) {
          root.decrementCurrentIndex();
          event.accepted = true;
        }
      } else if (event.key === Qt.Key_Tab) {
        root.incrementCurrentIndex();
        event.accepted = true;
      } else if (event.key === Qt.Key_Backtab || (event.key === Qt.Key_Tab && (event.modifiers & Qt.ShiftModifier))) {
        root.decrementCurrentIndex();
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
