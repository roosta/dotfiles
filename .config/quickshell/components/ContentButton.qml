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
//

Button {
  id: root

  default property alias content: rowLayout.data

  // color: Appearance.srcery.brightWhite
  required property string monitorId
  Layout.topMargin: Appearance.bar.borderWidth
  Layout.rightMargin: Appearance.spacing.p1
  // implicitWidth: Appearance.bar.height - Appearance.spacing.p3
  // implicitHeight: Appearance.bar.height - Appearance.bar.borderWidth
  //   - Appearance.spacing.p1 * 2

  // onPressed: {
  //   GlobalState.toggleLauncher({id: root.monitorId })
  // }

  HoverHandler {
    id: hover
    cursorShape: Qt.PointingHandCursor
  }

  background: BorderRect {
    id: outerRect
    color: Appearance.srcery.black
    borderColor: Appearance.srcery.gray3
    borderWidth: Appearance.bar.borderWidth
  }

  contentItem: RowLayout {
    id: rowLayout
  }

  states: [
    State {
      name: "pressed"
      when: root.pressed
      PropertyChanges { outerRect.borderColor: Appearance.srcery.brightWhite }
      PropertyChanges { contentItem.color: Appearance.srcery.brightWhite }
    },
    State {
      name: "hovered"
      when: hover.hovered
      PropertyChanges { outerRect.borderColor: Appearance.srcery.gray6 }
      PropertyChanges { hover.cursorShape: Qt.PointingHandCursor }
    },
  ]

  transitions: [
    Transition {
      NumberAnimation {
        properties: "rotation"
        duration: Appearance.durations.normal
        easing.type: Easing.OutCubic
      }
      ColorAnimation {
        duration: Appearance.durations.small
        easing.type: Easing.OutQuad
      }
    }
  ]
}
