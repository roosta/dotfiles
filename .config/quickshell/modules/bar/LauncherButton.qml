// ┌────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█░░░█▀█░█░█░█▀█░█▀▀░█░█░█▀▀░█▀▄░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█░░░█▀█░█░█░█░█░█░░░█▀█░█▀▀░█▀▄░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>               ├┤
// ││ Repo    : https://github.com/roosta/dotfiles         ││
// ││ Site    : https://www.roosta.sh                      ││
// ├┤ License : GNU General Public License v3              ├┤
// ┆└──────────────────────────────────────────────────────┘┆

pragma ComponentBehavior: Bound
// import qs.services
import qs.config
// import qs.utils
import qs.components
import qs
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
// import Quickshell
// import Quickshell.Hyprland
// import Quickshell.Wayland
// import Quickshell.Widgets

Item {
  required property string monitorId
  id: root

  signal decrementCurrentIndex()
  signal incrementCurrentIndex()
  signal accepted()

  property bool active: GlobalState.launcherOpen
  && GlobalState.launcherMonitorId === root.monitorId
  && GlobalState.launcherMode !== "notifications"

  Loader {
    active: true
    sourceComponent: fieldComponent
    anchors.fill: parent
    id: fieldLoader
    // opacity: root.active ? 1 : 0
    // Behavior on opacity {
    //   NumberAnimation { duration: Style.durations.small; easing.type: Easing.OutCubic }
    // }
  }

  Loader {
    active: !root.active
    sourceComponent: buttonComponent
    anchors.fill: parent
    id: buttonLoader
  }

  // property int fieldWidth: 1920 / 9 - Style.spacing.p1 - Style.bar.borderWidth
  Layout.topMargin: Style.bar.borderWidth
  implicitWidth: root.active ? 300 : Style.bar.height - Style.spacing.p3
  implicitHeight: Style.bar.height - Style.bar.borderWidth - Style.spacing.p1 * 2

  Behavior on implicitWidth {
    NumberAnimation {
      duration: Style.durations.small
      easing.type: Easing.OutCubic
    }
  }

  Component {
    id: buttonComponent
    Button {

      id: button
      // required property var appList;

      // color: Style.srcery.brightWhite

      anchors.fill: parent
      onPressed: {
        GlobalState.toggleLauncher({id: root.monitorId })
      }

      HoverHandler {
        id: hover
        cursorShape: Qt.PointingHandCursor
      }

      background: BorderRect {
        id: outerRect
        anchors.fill: parent
        borderColor: Style.srcery.gray3
        borderWidth: Style.bar.borderWidth
        GradientRect {
          id: innerRect
          implicitWidth: parent.height - Style.spacing.p1 * 2
          implicitHeight: parent.height - Style.spacing.p1 * 2
          gradientAngle: 45
          rotation: 45
          gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 1; color: Style.srcery.green }
            GradientStop { position: 0; color: Style.srcery.blue }
          }
          Rectangle {
            implicitWidth: 4
            implicitHeight: 4
            anchors.centerIn: parent
            radius: 4
            color: Style.srcery.brightBlue
          }
          anchors.margins: Style.spacing.p1
          anchors.top: parent.top
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          borderWidth: Style.bar.borderWidth
          color: Style.srcery.black
          // rotation: 45
          borderColor: Style.srcery.white
        }
      }

      NumberAnimation {
        target: innerRect
        running: hover.hovered && !root.active
        property: "gradientAngle"
        duration: 1000
        to: 405
        loops: Animation.Infinite;
        easing.type: Easing.Linear
      }

      states: [

        // State {
        //   name: "active"
        //   when: root.active && !hover.hovered
        //   PropertyChanges {
        //     // innerRect.rotation: 0
        //     innerRect.implicitWidth: Style.spacing.p1
        //     innerRect.color: Style.srcery.brightWhite
        //     innerRect.borderColor: Style.srcery.brightWhite
        //   }
        //   // PropertyChanges { outerRect.borderColor: Style.srcery.brightBlack }
        //   // PropertyChanges { innerRect.borderColor: Style.srcery.brightWhite }
        // },

        State {
          name: "hovered"
          when: hover.hovered && !root.active
          PropertyChanges { outerRect.borderColor: Style.srcery.gray6 }
          PropertyChanges { innerRect.gradientAngle: 360 }
        },

        // State {
        //   name: "activeHovered"
        //   when: hover.hovered && root.active
        //   PropertyChanges { outerRect.borderColor: Style.srcery.brightWhite }
        //   PropertyChanges { innerRect.borderColor: Style.srcery.brightWhite }
        //   // PropertyChanges { innerRect.rotation: 0 }
        // }
      ]

      transitions: [
        Transition {
          NumberAnimation {
            properties: "implicitWidth,implicitHeight"
            duration: Style.durations.small
            easing.type: Easing.OutCubic
          }
          ColorAnimation {
            duration: Style.durations.normal
            easing.type: Easing.OutCubic
          }
        }
      ]

    }
  }
  Component {
    id: fieldComponent
    TextField {

      Connections {
        target: GlobalState

        function onLauncherOpenChanged() {
          if (GlobalState.launcherOpen && GlobalState.launcherMonitorId === root.monitorId) {
            field.forceActiveFocus();
          }
        }
      }

      color: Style.srcery.brightWhite
      id: field
      leftPadding: Style.spacing.p1
      renderType: TextField.NativeRendering
      cursorVisible: !readOnly
      implicitWidth: 200
      placeholderTextColor: Style.srcery.gray3
      font.family: Style.font.light
      font.pointSize: Style.font.normal
      placeholderText: "  Search (/ for modes)"
      text: GlobalState.searchQuery
      onTextChanged: {
        if (text === Config.menuPrefix) {
          GlobalState.launcherMode = "menu"
        }
        const m = Config.launcherMenus.find(m => {
          return text.startsWith(`${Config.menuPrefix}/${m.mode}`)
        })
        if (m) {
          GlobalState.launcherMode = m[0]
          GlobalState.searchQuery = ""
        }
        GlobalState.searchQuery = text
      }
      background: Rectangle {
        color: "transparent"
        border.color: Style.srcery.gray3
      }

      function goPrevious() {
        if (GlobalState.menuDirection === Qt.LeftToRight) {
          return root.decrementCurrentIndex()
        } else if (GlobalState.menuDirection === Qt.RightToLeft) {
          return root.incrementCurrentIndex()
        }
      }

      function goNext() {
        if (GlobalState.menuDirection === Qt.LeftToRight) {
          return root.incrementCurrentIndex()
        } else if (GlobalState.menuDirection === Qt.RightToLeft) {
          return root.decrementCurrentIndex()
        }
      }

      Keys.onEscapePressed: GlobalState.closeLauncher()
      Keys.onRightPressed: goNext()
      Keys.onLeftPressed: goPrevious()
      Component.onCompleted: forceActiveFocus()
      onAccepted: root.accepted()

      // https://github.com/caelestia-dots/shell/blob/fe4ebb79b6162d7e5e4e9a00d8a39ff10876fb8c/modules/launcher/Content.qml#L109
      Keys.onPressed: event => {
        if (event.modifiers & Qt.ControlModifier) {
          if (event.key === Qt.Key_L) {
            goNext();
            event.accepted = true;
          } else if (event.key === Qt.Key_H) {
            goPrevious()
            event.accepted = true;
          }
        } else if (event.key === Qt.Key_Tab && GlobalState.matchCount === 1) {
          root.accepted()
          event.accepted = true;
        } else if (event.key === Qt.Key_Tab) {
          root.incrementCurrentIndex();
          event.accepted = true;
        } else if (event.key === Qt.Key_Backtab || (event.key === Qt.Key_Tab && (event.modifiers & Qt.ShiftModifier))) {
          root.decrementCurrentIndex();
          event.accepted = true;
        } else if (event.key == Qt.Key_Backspace && text === "" && GlobalState.launcherMode !== Config.defaultMode) {
          GlobalState.launcherMode = Config.defaultMode
          event.accepted = true
        } else if (event.key == Qt.Key_Backspace && text === "/" && GlobalState.launcherMode === "menu") {
          GlobalState.launcherMode = Config.defaultMode
          field.text = ""
          event.accepted = true
        }
      }
      // BorderRect {
      //   id: innerRect
      //   anchors.horizontalCenter: root.active ? undefined : parent.horizontalCenter
      //   implicitWidth: parent.width - Style.spacing.p1 * 2
      //   anchors.margins: Style.spacing.p1
      //   anchors.top: parent.top
      //   anchors.bottom: parent.bottom
      //   borderWidth: Style.bar.borderWidth
      //   color: Style.srcery.black
      //   // rotation: 45
      //   borderColor: Style.srcery.gray3
      // }
      cursorDelegate: GradientRect {
        id: cursor
        property bool disableBlink
        property bool visualActive: false

        // color: visualActive ? Style.srcery.brightWhite : "transparent"

        gradientAngle: 45
        rotation: visualActive ? 0 : 45

        property Gradient activeGradient: Gradient {
          orientation: Gradient.Horizontal
          GradientStop { position: 1; color: Style.srcery.green }
          GradientStop { position: 0; color: Style.srcery.blue }
        }

        property Gradient cursorGradient: Gradient {
          orientation: Gradient.Horizontal
          GradientStop { position: 1; color: Style.srcery.brightBlue }
        }
        gradient: visualActive ? cursorGradient : activeGradient
        // borderColor: Style.srcery.gray3
        // borderWidth: visualActive ? 0 : 1
        implicitWidth: visualActive ? Style.spacing.p1 : parent.height - Style.spacing.p1 * 2
        implicitHeight: parent.height - Style.spacing.p1 * 2

        Rectangle {
          implicitWidth: cursor.visualActive ? parent.implicitWidth : 4
          implicitHeight: cursor.visualActive ? parent.implicitHeight : 4
          // opacity: cursor.visualActive ? 0 : 1
          anchors.centerIn: parent
          radius: cursor.visualActive ? 0 : 4
          color: Style.srcery.brightBlue

          Behavior on implicitWidth {
            NumberAnimation {
              duration: Style.durations.normal
              easing.type: Easing.Linear
            }
          }
          Behavior on implicitHeight {
            NumberAnimation {
              duration: Style.durations.normal
              easing.type: Easing.Linear
            }
          }
        }
        Component.onCompleted: visualActive = true

        Connections {
          target: root
          function onActiveChanged() { cursor.visualActive = root.active }
        }

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
            duration: Style.durations.normal
            easing.type: Easing.InOutCubic
          }
        }
        Behavior on implicitWidth {
          NumberAnimation {
            duration: Style.durations.normal
            easing.type: Easing.InOutCubic
          }
        }

        Behavior on rotation {
          NumberAnimation {
            duration: Style.durations.normal
            easing.type: Easing.InOutCubic
          }
        }

        Behavior on color {
          ColorAnimation {
            duration: 500
            easing.type: Easing.OutQuad
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
