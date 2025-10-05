pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.config
// import qs
// import qs.utils
// import qs.components

TextField {
  color: Appearance.srcery.brightWhite
  id: root
  Layout.alignment: Qt.AlignHCenter
  cursorVisible: true
  renderType: TextField.NativeRendering

  placeholderTextColor: Appearance.srcery.gray3
  font.family: Appearance.font.light
  font.pointSize: Appearance.font.size1
  implicitWidth: parent.width * 0.6
  placeholderText: " Search..."
  background: Rectangle {
    color: "transparent"
    border.color: Appearance.srcery.gray3

  }

  // Component.onCompleted: forceActiveFocus()
  cursorDelegate: Rectangle {
    id: cursor
    property bool disableBlink
    color: Appearance.srcery.brightWhite
    implicitWidth: Appearance.spacing.p1

    Connections {
      target: root

      function onCursorPositionChanged(): void {
        if (root.activeFocus && root.cursorVisible) {
          cursor.opacity = 1;
          cursor.disableBlink = true;
          enableBlink.restart();
        }
      }
    }

    Timer {
      running: root.activeFocus && root.cursorVisible && !cursor.disableBlink
      repeat: true
      triggeredOnStart: true
      interval: 500
      onTriggered: parent.opacity = parent.opacity === 1 ? 0 : 1
    }
    Binding {
      when: !root.activeFocus || !root.cursorVisible
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
