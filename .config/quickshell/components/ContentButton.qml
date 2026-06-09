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

  // color: Style.srcery.brightWhite
  required property string monitorId
  Layout.topMargin: Style.bar.borderWidth
  Layout.rightMargin: Style.spacing.p1
  // implicitWidth: Style.bar.height - Style.spacing.p3
  // implicitHeight: Style.bar.height - Style.bar.borderWidth
  //   - Style.spacing.p1 * 2

  // onPressed: {
  //   GlobalState.toggleLauncher({id: root.monitorId })
  // }

  HoverHandler {
    id: hover
    cursorShape: Qt.PointingHandCursor
  }

  background: BorderRect {
    id: outerRect
    color: Style.srcery.black
    borderColor: Style.srcery.gray3
    borderWidth: Style.bar.borderWidth
  }

  contentItem: RowLayout {
    id: rowLayout
  }

  states: [
    State {
      name: "pressed"
      when: root.pressed
      PropertyChanges { outerRect.borderColor: Style.srcery.brightWhite }
      PropertyChanges { contentItem.color: Style.srcery.brightWhite }
    },
    State {
      name: "hovered"
      when: hover.hovered
      PropertyChanges { outerRect.borderColor: Style.srcery.gray6 }
      PropertyChanges { hover.cursorShape: Qt.PointingHandCursor }
    },
  ]

  transitions: [
    Transition {
      NumberAnimation {
        properties: "rotation"
        duration: Style.durations.normal
        easing.type: Easing.OutCubic
      }
      ColorAnimation {
        duration: Style.durations.small
        easing.type: Easing.OutQuad
      }
    }
  ]
}
