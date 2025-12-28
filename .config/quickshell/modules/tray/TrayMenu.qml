// GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
// Source: https://github.com/end-4/dots-hyprland/blob/5c141e0361adabdb7ea3575392309bec3a592af9/dots/.config/quickshell/ii/modules/ii/bar/SysTrayMenu.qml
// Modified by Daniel Berg <mail@roosta.sh>

pragma ComponentBehavior: Bound
import qs.config

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell

import Quickshell.Hyprland

Item {
  id: root
  required property QsMenuHandle trayItemMenuHandle
  required property string monitorId

  signal menuClosed
  signal menuOpened(qsWindow: var) // Correct type is QsWindow, but QML does not like that

  // color: Functions.transparentize("#000", 0.7)
  property real padding: Appearance.spacing.p1

  anchors.fill: parent
  anchors.bottomMargin: Appearance.bar.height + Appearance.spacing.p1
  anchors.rightMargin: Appearance.spacing.p1

  function open() {
    if (Hyprland.focusedMonitor?.name === root.monitorId) {
      root.visible = true
      root.menuOpened(root);
    } else {
      root.visible = false
    }
  }

  function close() {
    root.visible = false;
    while (stackView.depth > 1)
      stackView.pop();
    root.menuClosed();
  }

  Rectangle {
    color: "transparent"
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    MouseArea {
      acceptedButtons: Qt.BackButton | Qt.RightButton
      anchors.fill: parent
      onPressed: event => {
        if ((event.button === Qt.BackButton || event.button === Qt.RightButton) && stackView.depth > 1)
        stackView.pop();
      }
    }


    implicitHeight: {
      let result = 0;
      for (let child of stackView.children) {
        result = Math.max(child.implicitHeight, result);
      }
      return result + Appearance.spacing.p1 * 2
    }
    implicitWidth: {
      let result = 0;
      for (let child of stackView.children) {
        result = Math.max(child.implicitWidth, result);
      }
      return result + Appearance.spacing.p1 * 2
    }

    Rectangle {
      id: popupBackground
      readonly property real padding: Appearance.spacing.p1
      anchors {
        left: parent.left
        right: parent.right
        bottom: parent.bottom
      }

      color: Appearance.srcery.black
      border.width: 1
      border.color: Appearance.srcery.gray2
      clip: true

      opacity: 0
      Component.onCompleted: opacity = 1
      implicitWidth: stackView.implicitWidth + popupBackground.padding * 2
      implicitHeight: stackView.implicitHeight + popupBackground.padding * 2

      Behavior on opacity {
        NumberAnimation {
          duration: Appearance.durations.small
          easing.type: Easing.InOutCubic
        }
      }

      Behavior on implicitHeight {
        NumberAnimation {
          duration: Appearance.durations.small
          easing.type: Easing.InOutCubic
        }
      }

      Behavior on implicitWidth {
        NumberAnimation {
          duration: Appearance.durations.small
          easing.type: Easing.InOutCubic
        }
      }

      StackView {
        id: stackView
        anchors {
          fill: parent
          margins: Appearance.spacing.p1
        }
        pushEnter: NoAnim {}
        pushExit: NoAnim {}
        popEnter: NoAnim {}
        popExit: NoAnim {}

        implicitWidth: currentItem.implicitWidth
        implicitHeight: currentItem.implicitHeight

        initialItem: SubMenu {
          handle: root.trayItemMenuHandle
        }
      }
    }
  }

  component NoAnim: Transition {
    NumberAnimation {
      duration: 0
    }
  }

  component SubMenu: ColumnLayout {
    id: submenu
    required property QsMenuHandle handle
    property bool isSubMenu: false
    property bool shown: false
    opacity: shown ? 1 : 0

    Behavior on opacity {
      NumberAnimation {
        duration: Appearance.durations.small
        easing.type: Easing.InOutCubic
      }
    }

    Component.onCompleted: shown = true
    StackView.onActivating: shown = true
    StackView.onDeactivating: shown = false
    StackView.onRemoved: destroy()

    QsMenuOpener {
      id: menuOpener
      menu: submenu.handle
    }

    spacing: 0

    Loader {
      Layout.fillWidth: true
      visible: submenu.isSubMenu
      active: visible
      sourceComponent: Button {
        id: backButton
        horizontalPadding: Appearance.spacing.p1
        implicitWidth: contentItem.implicitWidth + horizontalPadding * 2
        implicitHeight: 36

        onPressed: () => stackView.pop()

        contentItem: RowLayout {
          anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            leftMargin: backButton.horizontalPadding
            rightMargin: backButton.horizontalPadding
          }
          spacing: Appearance.spacing.p1
          Text {
            text: ""
            color: Appearance.srcery.brightWhite
            font {
              family: Appearance.font.light
              pixelSize: Appearance.font.size3
            }
          }
          Text {
            Layout.fillWidth: true
            text: "Back"
            color: Appearance.srcery.brightWhite
          }
        }
      }
    }

    Repeater {
      id: menuEntriesRepeater
      property bool iconColumnNeeded: {
        for (let i = 0; i < menuOpener.children.values.length; i++) {
          if (menuOpener.children.values[i].icon.length > 0)
          return true;
        }
        return false;
      }
      property bool specialInteractionColumnNeeded: {
        for (let i = 0; i < menuOpener.children.values.length; i++) {
          if (menuOpener.children.values[i].buttonType !== QsMenuButtonType.None)
          return true;
        }
        return false;
      }
      model: menuOpener.children
      delegate: TrayMenuEntry {
        required property QsMenuEntry modelData
        forceIconColumn: menuEntriesRepeater.iconColumnNeeded
        forceSpecialInteractionColumn: menuEntriesRepeater.specialInteractionColumnNeeded
        menuEntry: modelData

        onDismiss: root.close()
        onOpenSubmenu: handle => {
          stackView.push(subMenuComponent.createObject(null, {
            handle: handle,
            isSubMenu: true
          }));
        }
      }
    }
  }

  Component {
    id: subMenuComponent
    SubMenu {}
  }
}
