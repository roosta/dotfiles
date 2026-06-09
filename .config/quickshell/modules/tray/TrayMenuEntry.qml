// ┌────────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█▄█░█▀▀░█▀█░█░█░█▀▀░█▀█░▀█▀░█▀▄░█░█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█░█░█▀▀░█░█░█░█░█▀▀░█░█░░█░░█▀▄░░█░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀░▀░░▀░░▀░▀░░▀░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>                   ├┤
// ││ Repo    : https://github.com/roosta/dotfiles             ││
// ││ Site    : https://www.roosta.sh                          ││
// ├┤ License : GNU General Public License v3                  ├┤
// ┆└──────────────────────────────────────────────────────────┘┆
// Source: https://github.com/end-4/dots-hyprland/blob/5c141e0361adabdb7ea3575392309bec3a592af9/dots/.config/quickshell/ii/modules/ii/bar/SysTrayMenuEntry.qml
// Modified 2026 by Daniel Berg <mail@roosta.sh>

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

// import qs.services
// import qs.components
import qs.config
// import qs

Button {
  id: root
  required property QsMenuEntry menuEntry
  property bool forceIconColumn: false
  property bool forceSpecialInteractionColumn: false
  readonly property bool hasIcon: menuEntry.icon.length > 0
  readonly property bool hasSpecialInteraction: menuEntry.buttonType !== QsMenuButtonType.None

  signal dismiss()
  signal openSubmenu(handle: QsMenuHandle)

  enabled: !menuEntry.isSeparator
  opacity: 1

  horizontalPadding: 12
  implicitWidth: contentItem.implicitWidth + horizontalPadding * 2
  implicitHeight: menuEntry.isSeparator ? 1 : 30
  Layout.topMargin: menuEntry.isSeparator ? 4 : 0
  Layout.bottomMargin: menuEntry.isSeparator ? 4 : 0
  Layout.fillWidth: true

  HoverHandler {
    id: hover
    cursorShape: Qt.PointingHandCursor
  }

  background: Rectangle {
    implicitHeight: 30
    id: buttonBackground
    color: {
      if (root.menuEntry.isSeparator) {
        return Style.srcery.gray4
      } else if (root.hovered) {
        return Style.srcery.gray1
      } else {
        return Style.srcery.black
      }
    }
  }
  onReleased: () => {
    if (menuEntry.hasChildren) {
      root.openSubmenu(root.menuEntry);
      return;
    }
    menuEntry.triggered();
    root.dismiss();
  }
  contentItem: RowLayout {
    id: contentItem
    anchors {
      verticalCenter: parent.verticalCenter
      left: parent.left
      right: parent.right
      leftMargin: root.horizontalPadding
      rightMargin: root.horizontalPadding
    }
    spacing: 8
    visible: !root.menuEntry.isSeparator

    // Interaction: checkbox or radio button
    Item {
      visible: root.hasSpecialInteraction || root.forceSpecialInteractionColumn
      implicitWidth: 20
      implicitHeight: 20

      Loader {
        anchors.fill: parent
        active: root.menuEntry.buttonType === QsMenuButtonType.RadioButton

        sourceComponent: RadioButton {
          enabled: false
          padding: 0
          checked: root.menuEntry.checkState === Qt.Checked
        }
      }

      Loader {
        anchors.fill: parent
        active: root.menuEntry.buttonType === QsMenuButtonType.CheckBox && root.menuEntry.checkState !== Qt.Unchecked
        sourceComponent: Text {
          text: root.menuEntry.checkState === Qt.PartiallyChecked ? "" : ""
          color: Style.srcery.brightWhite
          font {
            family: Style.font.light
            pixelSize: Style.font.size3
          }
        }
      }
    }

    // Button icon
    Item {
      visible: root.hasIcon || root.forceIconColumn
      implicitWidth: 20
      implicitHeight: 20

      Loader {
        anchors.centerIn: parent
        active: root.menuEntry.icon.length > 0
        sourceComponent: IconImage {
          asynchronous: true
          source: root.menuEntry.icon
          implicitSize: 20
          mipmap: true
        }
      }
    }

    Text {
      id: label
      text: root.menuEntry.text
      font.pointSize: Style.font.small
      Layout.fillWidth: true
      color: Style.srcery.brightWhite
    }

    Loader {
      active: root.menuEntry.hasChildren

      sourceComponent: Text {
        text: ""
        color: Style.srcery.brightWhite
        font {
          family: Style.font.light
          pointSize: Style.font.normal
        }
      }
    }
  }
}
