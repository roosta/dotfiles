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
  RowLayout {
    anchors.fill: parent
    anchors.centerIn: parent
    anchors.margins: Appearance.spacing.p4
    ComboBox {
      id: control
      model: Object.entries(Config.menus).map(([k, v]) => v.name)
      Layout.fillHeight: true

      HoverHandler {
        id: hover
        cursorShape: Qt.PointingHandCursor
      }

      states: State {
        name: "hovered"
        when: hover.hovered
        PropertyChanges {
          comboBg.border.color: Appearance.srcery.gray6
        }
      }
      delegate: ItemDelegate {
        id: delegate

        required property var model
        required property int index

        width: control.width
        contentItem: Text {
          text: `${Config.prefix}${delegate.model[control.textRole]}`
          color: delegate.highlighted ? Appearance.srcery.brightWhite : Appearance.srcery.white
          font.family: Appearance.font.light
          font.pointSize: Appearance.font.size1
          verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
          color: delegate.highlighted ? Appearance.srcery.gray3 : "transparent"
        }
        highlighted: control.highlightedIndex === index
      }

      indicator: Canvas {
        id: canvas
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: Appearance.spacing.p2
        height: Appearance.spacing.p1
        contextType: "2d"

        Connections {
          target: control
          function onPressedChanged() { canvas.requestPaint(); }
        }

        onPaint: {
          context.reset();
          context.moveTo(0, 0);
          context.lineTo(width, 0);
          context.lineTo(width / 2, height);
          context.closePath();
          context.fillStyle = control.pressed ? Appearance.srcery.brightBlack : Appearance.srcery.gray6;
          context.fill();
        }
      }

      contentItem: Text {
        leftPadding: Appearance.spacing.p0
        rightPadding: control.indicator.width + control.spacing

        text: `${Config.prefix}${control.displayText}`
        color: control.pressed ? Appearance.srcery.brightBlack : Appearance.srcery.gray6
        verticalAlignment: Text.AlignVCenter
        font.family: Appearance.font.light
        font.pointSize: Appearance.font.size1
        elide: Text.ElideRight
      }

      background: Rectangle {
        id: comboBg
        implicitWidth: 90
        // implicitHeight: 40
        color: "transparent"
        border.color: control.pressed ? Appearance.srcery.gray6 : Appearance.srcery.gray3
        border.width: Appearance.bar.borderWidth
      }
      popup: Popup {
        y: control.height + Appearance.spacing.p1
        width: control.width
        height: Math.min(contentItem.implicitHeight, control.Window.height - topMargin - bottomMargin)
        padding: 0

        contentItem: ListView {
          clip: true
          implicitHeight: contentHeight
          model: control.popup.visible ? control.delegateModel : null
          currentIndex: control.highlightedIndex

          ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
          implicitWidth: 100
          border.color: Appearance.srcery.gray3
          color: Appearance.srcery.black
          radius: 0
        }
      }
    }
    TextField {
      color: Appearance.srcery.brightWhite
      id: field
      Layout.fillWidth: true
      // Layout.alignment: Qt.AlignHCenter | Qt.alignLeft
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
  
}
