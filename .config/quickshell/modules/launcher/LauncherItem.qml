pragma ComponentBehavior: Bound
import Quickshell.Widgets
import qs
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import qs.utils
import qs.config
import qs.services

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
  property var categories
  property bool isCurrentItem: ListView.isCurrentItem
  anchors.top: parent?.top
  anchors.bottom: parent?.bottom
  // height: parent?.height ?? 0
  implicitWidth: {
    if (parentWidth <= 0) return 0
    return parentWidth / 6 - Appearance.spacing.p1 - Appearance.bar.borderWidth
  }
  signal clicked()
  property string iconSource: ""
  property string imageSource: ""
  property int iconSize: 42
  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true

    onClicked: {
      root.clicked()
    }
  }
  states: [

    State {
      name: "hovered"
      when: mouseArea.containsMouse && !mouseArea.pressed && !root.isCurrentItem
      PropertyChanges { mouseArea.cursorShape: Qt.PointingHandCursor }
      PropertyChanges { card.border.color: Appearance.srcery.gray6 }
    },

    State {
      name: "current"
      when: root.isCurrentItem && !mouseArea.pressed && !mouseArea.containsMouse
      PropertyChanges { card.color: Appearance.srcery.gray1 }
    },

    State {
      name: "currentHovered"
      when: root.isCurrentItem && !mouseArea.pressed && mouseArea.containsMouse
      PropertyChanges { card.color: Appearance.srcery.gray1 }
      PropertyChanges { card.border.color: Appearance.srcery.gray6 }
      PropertyChanges { mouseArea.cursorShape: Qt.PointingHandCursor }
    },

    State {
      name: "pressed"
      when: mouseArea.pressed && !root.isCurrentItem
      PropertyChanges { card.border.color: Appearance.srcery.white }
      PropertyChanges { card.color: Appearance.srcery.gray1 }
    },

    State {
      name: "pressedCurrent"
      when: mouseArea.pressed && root.isCurrentItem
      PropertyChanges { card.border.color: Appearance.srcery.white }
      PropertyChanges { card.color: Appearance.srcery.gray2 }
    }

  ]

  Rectangle {
    id: card
    anchors.fill: parent
    border.color: Appearance.srcery.gray3
    color: Appearance.srcery.black
    border.width: Appearance.bar.borderWidth

    Behavior on color {
      ColorAnimation {
        duration: Appearance.durations.tiny
        easing.type: Easing.InOutQuad
      }
    }

    ColumnLayout {
      opacity: GlobalState.launcherOpen ? 1 : 0

    Behavior on opacity {
      NumberAnimation {
        property: "opacity"
        duration: Appearance.durations.small
        easing.type: Easing.InOutQuad
      }
    }
      id: layout
      anchors.margins: Appearance.spacing.p2
      Layout.alignment: Qt.AlignTop
      anchors.fill: parent
      RowLayout {
        Layout.fillWidth: true
        spacing: Appearance.spacing.p1
        Layout.preferredHeight: root.iconSize
        Rectangle {
          implicitWidth: root.iconSize
          implicitHeight: root.iconSize
          id: iconRect
          radius: 4
          color: Functions.transparentize(Appearance.srcery.black, 0.7)
          border.color: Appearance.srcery.gray3
          Loader {
            active: root.iconSource !== ""
            anchors.fill: parent
            sourceComponent: IconImage {
              id: icon
              anchors.fill: parent
              source: root.iconSource
              anchors.margins: Appearance.spacing.p2
            }
          }
          Loader {
            active: root.imageSource !== ""
            anchors.fill: parent
            sourceComponent: Image {
              id: image
              source: root.imageSource
              anchors.fill: parent
              anchors.margins: Appearance.spacing.p2

            }
          }
        }

        ColumnLayout {
          Layout.alignment: Qt.AlignTop
          spacing: Appearance.spacing.p0
          RowLayout {
            Text {
              id: name
              elide: Text.ElideRight
              Layout.fillWidth: true
              text: {
                if (root.name) {
                  return root.name
                } else {
                  "(No name)"
                }
              }
              color: Appearance.srcery.brightWhite
              font {
                family: Appearance.font.light
                pointSize: Appearance.font.large
              }
            }

            Text {
              color: Appearance.srcery.brightBlack
              id: favorite
              visible: root.favorite
              text: ""
              font {
                family: Appearance.font.light
                pixelSize: Appearance.font.large
              }
            }

            Loader {
              active: root.canClose
              sourceComponent: Button {
                id: closeButton
                states: [
                  State {
                    name: "hovered"
                    when: closeMouseArea.containsMouse
                    PropertyChanges { closeRect.border.color: Appearance.srcery.gray6 }
                    PropertyChanges { closeContent.color: Appearance.srcery.white }
                    PropertyChanges { closeMouseArea.cursorShape: Qt.PointingHandCursor }
                  }
                ]
                transitions: [
                  Transition {
                    ColorAnimation {
                      duration: Appearance.durations.tiny
                      easing.type: Easing.OutQuad
                    }
                  }
                ]
                MouseArea {
                  id: closeMouseArea
                  anchors.fill: parent
                  hoverEnabled: true

                  onClicked: {
                    Notifications.discardNotification(root.notificationId)
                  }
                }
                background: Rectangle {
                  id: closeRect
                  color: Appearance.srcery.black
                  border.width: Appearance.bar.borderWidth
                  border.color: Appearance.srcery.gray3
                  radius: 2
                }
                contentItem: Text {
                  id: closeContent
                  color: Appearance.srcery.brightBlack
                  text: ""
                  font {
                    family: Appearance.font.light
                    pixelSize: Appearance.font.normal
                  }
                }
              }
            }
          }


          RowLayout {
            Text {
              id: generic
              elide: Text.ElideRight
              Layout.fillWidth: true
              text: {
                if (root.genericName) {
                  return root.genericName
                } else {
                  return "Application"
                }
              }
              color: Appearance.srcery.white
              font {
                family: Appearance.font.main
                pointSize: Appearance.font.small
              }
            }

            Text {
              Layout.preferredWidth: 24
              color: Appearance.srcery.brightGreen
              horizontalAlignment: Qt.AlignRight
              id: timeElapsedText
              visible: root.timeElapsed !== ""
              text: root.timeElapsed
              font {
                family: Appearance.font.light
                pixelSize: Appearance.font.large
              }
            }
          }
        }
      }

      Text {
        color: Appearance.srcery.white
        text: {
          if (root.description) {
            return root.description
          } else {
            return "No description defined for this desktop entry..."
          }
        }
        Layout.fillWidth: true
        Layout.fillHeight: true
        elide: Text.ElideRight
        wrapMode: Text.Wrap
        font {
          family: Appearance.font.light
          pointSize: Appearance.font.small
        }
      }

      Item {
        Layout.fillHeight: true
      }

      ColumnLayout {
        Layout.fillWidth: true
        visible: root.categories?.length > 0
        Rectangle {
          implicitHeight: Appearance.bar.borderWidth
          Layout.fillWidth: true
          color: Appearance.srcery.gray3
        }
        Text {
          text: root.categories.join(", ")
          color: Appearance.srcery.brightBlack
          elide: Text.ElideRight
          Layout.fillWidth: true
          wrapMode: Text.Wrap
          font {
            family: Appearance.font.light
            pointSize: Appearance.font.tiny
          }
        }
      }
    }
  }
}

