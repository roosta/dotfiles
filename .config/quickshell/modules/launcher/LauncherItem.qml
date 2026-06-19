// ┌────────────────────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█░░░█▀█░█░█░█▀█░█▀▀░█░█░█▀▀░█▀▄░▀█▀░▀█▀░█▀▀░█▄█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█░░░█▀█░█░█░█░█░█░░░█▀█░█▀▀░█▀▄░░█░░░█░░█▀▀░█░█░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀░▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>                               ├┤
// ││ Repo    : https://github.com/roosta/dotfiles                         ││
// ││ Site    : https://www.roosta.sh                                      ││
// ├┤ License : GNU General Public License v3                              ├┤
// ┆└──────────────────────────────────────────────────────────────────────┘┆

pragma ComponentBehavior: Bound
import Quickshell.Widgets
import qs
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import qs.utils
import qs.config
import qs.services
import qs.components

Item {
  id: root
  property string name
  property string description
  property int notificationId: -1
  property bool canClose: notificationId >= 0
  property string genericName
  property int parentWidth: 1920
  property bool favorite: false
  property string timeElapsed: ""
  property var categories: []
  property var actions: []
  property bool isNotification: false
  property bool isCurrentItem: ListView.isCurrentItem
  anchors.top: parent?.top
  anchors.bottom: parent?.bottom
  // height: parent?.height ?? 0
  implicitWidth: {
    if (parentWidth <= 0) return 0
    return parentWidth / 9 - Style.spacing.p1 - Style.bar.borderWidth
  }
  signal clicked()
  property string iconSource: ""
  property string imageSource: ""
  property int iconSize: 40

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: {
      root.clicked()
    }
  }
  states: [

    State {
      name: "hovered"
      when: (mouseArea.containsMouse || actionsArea.hovered) && !mouseArea.pressed && !root.isCurrentItem
      PropertyChanges { card.color: Style.srcery.gray1 }
    },

    State {
      name: "current"
      when: root.isCurrentItem && !mouseArea.pressed && (!mouseArea.containsMouse && !actionsArea.hovered)
      // PropertyChanges { card.color: Style.srcery.gray1 }
    },

    State {
      name: "currentHovered"
      when: root.isCurrentItem && !mouseArea.pressed && (mouseArea.containsMouse || actionsArea.hovered)
      PropertyChanges { card.color: Style.srcery.gray1 }
      // PropertyChanges { card.border.color: Style.srcery.gray6 }
    },

    State {
      name: "pressed"
      when: mouseArea.pressed && !root.isCurrentItem
      PropertyChanges { card.border.color: Style.srcery.white }
      PropertyChanges { card.color: Style.srcery.gray1 }
      PropertyChanges { drawer.border.color: Style.srcery.white }
    },

    State {
      name: "pressedCurrent"
      when: mouseArea.pressed && root.isCurrentItem
      PropertyChanges { card.border.color: Style.srcery.white }
      PropertyChanges { card.color: Style.srcery.gray2 }
    }

  ]

  Rectangle {
    id: card
    anchors.fill: parent
    border.color: Style.srcery.gray3
    color: Style.srcery.black
    border.width: Style.bar.borderWidth

    Text {
      color: Style.srcery.brightGreen
      id: timeElapsedText
      visible: root.timeElapsed !== ""
      x: Style.spacing.p2
      y: Style.spacing.p2
      text: root.timeElapsed
      font {
        family: Style.font.light
        pixelSize: Style.font.large
      }
    }

    Loader {
      active: root.canClose
      sourceComponent: Button {
        id: closeButton
        x: card.width - width - Style.spacing.p2
        y: Style.spacing.p2
        states: [
          State {
            name: "hovered"
            when: closeMouseArea.containsMouse
            PropertyChanges { closeRect.border.color: Style.srcery.gray6 }
            PropertyChanges { closeContent.color: Style.srcery.white }
          }
        ]
        transitions: [
          Transition {
            ColorAnimation {
              duration: Style.durations.tiny
              easing.type: Easing.OutQuad
            }
          }
        ]
        MouseArea {
          id: closeMouseArea
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: Qt.PointingHandCursor

          onClicked: {
            Notifications.discardNotification(root.notificationId)
          }
        }
        background: Rectangle {
          id: closeRect
          color: Style.srcery.black
          border.width: Style.bar.borderWidth
          border.color: Style.srcery.gray3
          radius: 2
        }
        contentItem: Text {
          id: closeContent
          color: Style.srcery.brightBlack
          text: ""
          font {
            family: Style.font.light
            pixelSize: Style.font.normal
          }
        }
      }
    }

    Behavior on color {
      ColorAnimation {
        duration: Style.durations.tiny
        easing.type: Easing.InOutQuad
      }
    }

    ColumnLayout {
      opacity: GlobalState.launcherOpen ? 1 : 0

      Behavior on opacity {
        NumberAnimation {
          property: "opacity"
          duration: Style.durations.small
          easing.type: Easing.InOutQuad
        }
      }
      id: layout
      anchors.margins: Style.spacing.p3
      Layout.alignment: Qt.AlignTop
      anchors.fill: parent

      ColumnLayout {
        Layout.fillWidth: true
        spacing: Style.spacing.p2

        Item {
          implicitWidth: 120
          implicitHeight: 100
          Layout.alignment: Qt.AlignHCenter
          id: iconRect

          Triangle {
            anchors.fill: parent


            ColumnLayout {
              anchors.fill: parent

              // TODO: fix this, not sure why the text element takes up so much space
              spacing: -16
              Text {
                color: Style.srcery.brightYellow
                id: favorite
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: Style.spacing.p3
                opacity: root.favorite ? 1 : 0
                text: "󰓒"
                font {
                  family: Style.font.main
                  pixelSize: Style.font.xl
                }
              }
              Loader {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: root.iconSize
                Layout.preferredHeight: root.iconSize
                sourceComponent: {
                  if (root.iconSource !== "") return iconComponent
                  if (root.imageSource !== "") return imageComponent
                  return null
                }
              }

              Component {
                id: iconComponent
                IconImage {
                  source: root.iconSource
                  width: root.iconSize
                  height: root.iconSize
                }
              }

              Component {
                id: imageComponent
                Image {
                  source: root.imageSource
                  width: root.iconSize
                  height: root.iconSize
                }
              }
            }
          }
        }

        Text {
          id: name
          elide: Text.ElideRight
          Layout.fillWidth: true
          horizontalAlignment: Text.AlignHCenter
          text: {
            if (root.name) {
              return root.name
            } else {
              "(No name)"
            }
          }
          color: Style.srcery.brightYellow
          font {
            family: Style.font.light
            pointSize: Style.font.large
          }
        }




        Text {
          id: generic
          elide: Text.ElideRight
          Layout.fillWidth: true
          horizontalAlignment: Text.AlignHCenter
          text: {
            if (root.genericName) {
              return root.genericName
            } else {
              return "Application"
            }
          }
          color: Style.srcery.brightWhite
          font {
            family: Style.font.main
            pointSize: Style.font.small
          }
        }

        Loader {
          active: root.categories.length > 0
          Layout.fillWidth: true
          sourceComponent: Text {
            text: root.categories.join(" · ")
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            color: Style.srcery.brightBlue
            elide: Text.ElideRight
            // wrapMode: Text.Wrap
            font {
              family: Style.font.light
              pointSize: Style.font.tiny
            }
          }
        }

      }

      Text {
        color: Style.srcery.white
        text: {
          if (root.description) {
            return root.description
          } else {
            return "No description defined for this desktop entry..."
          }
        }
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.bottomMargin: 20
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.Wrap
        font {
          family: Style.font.light
          pointSize: Style.font.small
        }
      }

    }
    Rectangle {
      id: drawer
      property bool drawerExpanded: false

      implicitHeight: {
        if (drawerExpanded && root.actions.length > 0) {
          return 140
        } else {
          return 26
        }
      }
      anchors.left: parent.left
      anchors.right: parent.right
      color: Style.srcery.black
      anchors.bottom: parent.bottom
      border.width: 1
      border.color: Style.srcery.gray3

      HoverHandler {
        id: actionsArea
        onHoveredChanged: {
          if (actionsArea.hovered) {
            collapseTimer.stop()
            drawer.drawerExpanded = true
          } else {
            collapseTimer.start()
          }
        }
      }

      Timer {
        id: collapseTimer
        interval: Style.durations.medium
        onTriggered: drawer.drawerExpanded = false
      }

      MouseArea {
        anchors.fill: parent
        onClicked: {}
      }

      Behavior on implicitHeight {
        NumberAnimation {
          duration: Style.durations.small
          easing.type: Easing.InOutCubic
        }
      }

      Item {
        id: actionPane
        clip: true
        anchors.margins: Style.spacing.p1
        anchors.fill: parent
        ColumnLayout {
          anchors.fill: parent
          Text {
            text: {
              if (root.actions.length > 0) {
                return `${root.actions.length} actions`
              } else {
                return "No actions"
              }
            }
            color: Style.srcery.brightBlack
            font {
              family: Style.font.light
              pointSize: Style.font.tiny
            }
          }
          Loader {
            active: root.actions.length > 0
            Layout.fillWidth: true

            sourceComponent: Flow {
              spacing: Style.spacing.p1
              anchors.fill: parent
              Repeater {
                id: actionRepeater
                model: root.actions
                Button {
                  id: actionButton
                  required property var modelData
                  required property int index
                  padding: Style.spacing.p0

                  HoverHandler {
                    id: hover
                    cursorShape: Qt.PointingHandCursor
                  }
                  states: [
                    State {
                      name: "hovered"
                      when: actionButton.hovered
                      PropertyChanges {
                        actionBg.border.color: Style.srcery.brightBlack
                        actionText.color: Style.srcery.white
                      }
                    }
                  ]
                  transitions: [
                    Transition {
                      ColorAnimation {
                        duration: Style.durations.tiny
                        easing.type: Easing.OutQuad
                      }
                    }
                  ]
                  onPressed: {
                    if (root.isNotification) {
                      Notifications.discardNotification(root.notificationId)
                    }
                    LauncherData.launch(modelData)
                    GlobalState.closeLauncher()
                  }
                  background: Rectangle {
                    id: actionBg
                    border.width: 1
                    border.color: Style.srcery.gray3
                    color: Style.srcery.gray1

                  }
                  contentItem: Text {
                    id: actionText
                    text: {
                      return actionButton.modelData?.name ?? actionButton.modelData?.text ?? ""
                    }
                    color: Style.srcery.brightBlack
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                    wrapMode: Text.Wrap
                    font {
                      family: Style.font.light
                      pointSize: Style.font.tiny
                    }
                  }
                }
              }
            }
          }

          Item { Layout.fillHeight: true }
        }
      }
    }
  }
}

