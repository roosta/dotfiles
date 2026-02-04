import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick
import qs.utils
import qs.config

Item {
  id: root
  property string name
  property string description
  property string genericName
  property int parentWidth: 1920
  property bool favorite: false
  property var categories
  anchors.top: parent?.top
  anchors.bottom: parent?.bottom
  implicitWidth: {
    if (parentWidth <= 0) return 0
    return parentWidth / 6 - Appearance.spacing.p1 - Appearance.bar.borderWidth
  }
  signal clicked()
  property alias iconSource: icon.source
  property int iconSize: 42
  MouseArea {
    id: mouse
    anchors.fill: parent
    hoverEnabled: true

    HoverHandler {
      id: hover
      cursorShape: Qt.PointingHandCursor
    }
    onClicked: {
      root.clicked()
    }
  }
  Rectangle {
    anchors.fill: parent
    border.color: mouse.containsMouse ? Appearance.srcery.gray6 : Appearance.srcery.gray3
    color: "transparent"
    border.width: Appearance.bar.borderWidth

    Behavior on color {
      ColorAnimation {
        duration: 150
        easing.type: Easing.OutQuad
      }
    }
    ColumnLayout {

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
          IconImage {
            id: icon
            anchors.fill: parent
            anchors.margins: Appearance.spacing.p2
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
              wrapMode: Text.Wrap
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
          }
          Text {
            id: generic
            elide: Text.ElideRight
            Layout.fillWidth: true
            wrapMode: Text.Wrap
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

