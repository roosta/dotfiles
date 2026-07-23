// ┌────────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█░█░█▀█░█▀▄░█░█░█▀▀░█▀█░█▀█░█▀▀░█▀▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█▄█░█░█░█▀▄░█▀▄░▀▀█░█▀▀░█▀█░█░░░█▀▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░░░▀░▀░▀▀▀░▀▀▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>                   ├┤
// ││ Repo    : https://github.com/roosta/dotfiles             ││
// ││ Site    : https://www.roosta.sh                          ││
// ├┤ License : GNU General Public License v3                  ├┤
// ┆└──────────────────────────────────────────────────────────┘┆

pragma ComponentBehavior: Bound
// import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Hyprland
import qs.services
// import qs.utils
import qs.config
import qs.components
import qs.utils
// import qs.widgets

Button {
  id: root
  required property bool isOccupied
  required property int workspaceId
  required property int activeWorkspaceId
  readonly property bool isWorkspace: true
  required property var modelData
  required property string monitorId
  property bool active: activeWorkspaceId === workspaceId
  property bool urgent: {
    return HyprlandData.urgentWindows.some(win => {
      return win.workspace.id === root.workspaceId
    })
  }

  property bool scratchActive: HyprlandData.scratchActive
    && HyprlandData.scratchEventData.includes(monitorId)
  property int buttonSize: 26 * Config.scale
  property int iconSize: 16 * Config.scale
  property int calculatedWidth: {
    if (root.isOccupied) {
      let iconCount = Icons.getWsIcons(workspaceId).length ?? 0;
      return iconCount * (root.iconSize + Style.spacing.p3);
    } else {
      return root.iconSize + Style.spacing.p3;
    }
  }

  onPressed: {
    if (workspaceId !== activeWorkspaceId) {
      Hyprland.dispatch(`hl.dsp.focus({ workspace = ${workspaceId} })`)
    }
  }
  HoverHandler {
    id: hover
    cursorShape: root.active ? Qt.ArrowCursor : Qt.PointingHandCursor
  }

  background: GradientRect {
    id: wsBackground
    implicitWidth: root.calculatedWidth
    implicitHeight: childrenRect.height
    radius: Style.bar.radius
    color: "transparent"
    borderColor: {
      if (!root.isOccupied)
        return Style.srcery.black
      if (root.urgent)
        return (hover.hovered && !root.active) ? Style.srcery.gray6 : Style.srcery.gray2
      return (root.active || hover.hovered) ? Style.srcery.brightBlack : Style.srcery.gray2
    }

    // gradientAngle: 45
    property Gradient activeGradient: Gradient {
      orientation: Gradient.Horizontal
      GradientStop { position: 1; color: Style.srcery.cyan }
      GradientStop { position: 0; color: Style.srcery.white }
    }
    property bool isScratch: HyprlandData.scratch.id === root.workspaceId
    gradient: activeGradient
    gradientActive: isScratch && HyprlandData.scratchActive
    dashed: isScratch
    borderWidth: Style.bar.borderWidth

    Behavior on borderColor {
      ColorAnimation {
        duration: Style.durations.normal
        easing.type: Easing.OutCubic
      }
    }

    Loader {
      active: !root.isOccupied
      sourceComponent: indicator
    }
    Component {
      id: indicator
      Item {
        implicitWidth: root.iconSize + Style.spacing.p3
        implicitHeight: Style.bar.height - Style.bar.borderWidth
        - Style.spacing.p1 * 2

        Rectangle {
          id: circle
          anchors.centerIn: parent
          width: root.buttonSize * 0.25
          height: width
          radius: width / 2
          color: (root.hovered || root.active) ? Style.srcery.brightWhite : Style.srcery.gray6
          Behavior on color {
            ColorAnimation {
              duration: Style.durations.small
              easing.type: Easing.OutQuad
            }
          }
        }
      }
    }

    Loader {
      active: root.isOccupied
      sourceComponent: iconGroup
    }
    Component {
      id: iconGroup
      RowLayout {
        spacing: 0
        Repeater {
          model: Icons.getWsIcons(root.workspaceId)
          Item {
            required property var modelData
            property bool urgent:  {
              return HyprlandData.urgentWindows.some(win => {
                return root.urgent && win.class === modelData.class
              })
            }

            id: appIcon
            Layout.preferredWidth: root.iconSize + Style.spacing.p3
            Layout.preferredHeight: Style.bar.height - Style.bar.borderWidth - Style.spacing.p1 * 2

            SequentialAnimation {
              id: blinkAnimation
              running: appIcon.urgent
              loops: Animation.Infinite
              onRunningChanged: if (!running) desaturatedIcon.opacity = 1.0

              PropertyAnimation {
                target: desaturatedIcon
                property: "opacity"
                from: 1.0
                to: 0.3
                duration: Style.durations.normal
                easing.type: Easing.InOutQuad
              }
              PropertyAnimation {
                target: desaturatedIcon
                property: "opacity"
                from: 0.3
                to: 1.0
                duration: Style.durations.normal
                easing.type: Easing.InOutQuad
              }
              // PropertyAnimation {
              //   target: desaturatedIcon
              //   property: "opacity"
              //   from: 0.3
              //   to: 1.0
              //   duration: Style.durations.normal
              //   easing.type: Easing.InOutQuad
              // }
            }

            MultiEffect {
              id: desaturatedIcon
              implicitWidth: root.iconSize
              implicitHeight: root.iconSize
              anchors.centerIn: parent

              // grayscale scratch icons unless the scratch is active
              saturation: (wsBackground.isScratch && !HyprlandData.scratchActive) ? -1.0 : 0.0

              Behavior on saturation {
                NumberAnimation {
                  duration: Style.durations.small
                  easing.type: Easing.OutCubic
                }
              }
              source: IconImage {
                source: appIcon.modelData.icon
                implicitSize: root.iconSize

                // opacity: 0
                // scale: 0.8
                //
                // Component.onCompleted: {
                //   opacity = 1
                //   scale = 1
                // }
                //
                // Behavior on opacity {
                //   NumberAnimation {
                //     duration: 300
                //     easing.type: Easing.OutCubic
                //   }
                // }
                //
                // Behavior on scale {
                //   NumberAnimation {
                //     duration: 300
                //     easing.type: Easing.OutCubic
                //   }
                // }
              }
            }


          }
        }
      }
    }
  }
  // states: [
  //   State {
  //     name: "hovered"
  //     when: root.hovered
  //     PropertyChanges { root.saturation: 0.0 }
  //   }
  // ]
}
