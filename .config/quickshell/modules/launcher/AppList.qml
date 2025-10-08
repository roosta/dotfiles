pragma ComponentBehavior: Bound
import Quickshell
import QtQuick.Layouts
import QtQuick.Templates
import QtQuick
import qs.config
import qs.components
import qs.services

Rectangle {
  id: root
  required property SearchField search
  Layout.fillWidth: true
  Layout.fillHeight: true
  
  Layout.topMargin: Appearance.bar.borderWidth
  Layout.leftMargin: Appearance.spacing.p4 + Appearance.bar.borderWidth
  Layout.rightMargin: Appearance.spacing.p4 + Appearance.bar.borderWidth
  // Layout.bottomMargin: -5
  color: "transparent"
  clip: true

  ListView {
    id: list
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.topMargin: Appearance.spacing.p4
    anchors.bottomMargin: Appearance.spacing.p4
    orientation: Qt.Vertical
    spacing: Appearance.spacing.p2
    preferredHighlightBegin: 0
    preferredHighlightEnd: height
    // highlightFollowsCurrentItem: false
    // highlight: BorderRectangle {
    //   color: Appearance.srcery.gray3
    //   opacity: 0.08
    //   y: list.currentItem?.y ?? 0
    //   implicitWidth: list.width
    //   implicitHeight: list.currentItem?.implicitHeight ?? 0
    // }
    model: ScriptModel {
      id: model
      onValuesChanged: list.currentIndex = 0
      values: AppSearch.fuzzyQuery(root.search.text)
    }

    add: Transition {
      enabled: !list.state

      NumberAnimation {
        properties: "opacity,scale"
        easing.type: Easing.InCubic
        duration: Appearance.durations.normal
        from: 0
        to: 1
      }
    }

    move: Transition {
      NumberAnimation {
        properties: "y"
        easing.type: Easing.InOutCubic
        duration: Appearance.durations.normal
      }

      NumberAnimation {
        properties: "opacity,scale"
        easing.type: Easing.InOutCubic
        duration: Appearance.durations.normal
        to: 1
      }
    }
    remove: Transition {
      enabled: !list.state

      NumberAnimation {
        properties: "opacity,scale"
        easing.type: Easing.OutCubic
        duration: Appearance.durations.normal
        from: 0
        to: 1
      }
    }
    delegate: AppItem { }

    transitions: Transition {
      SequentialAnimation {
        ParallelAnimation {
          NumberAnimation {
            target: list
            property: "opacity"
            from: 1
            to: 0
            duration: Appearance.durations.small
            easing.type: Easing.InOutCubic
          }
          NumberAnimation {
            target: list
            property: "scale"
            from: 1
            to: 0.9
            duration: Appearance.durations.small
            easing.type: Easing.InOutCubic
          }
        }
        PropertyAction {
          targets: [model, list]
          properties: "values,delegate"
        }
        ParallelAnimation {
          NumberAnimation {
            target: list
            property: "opacity"
            from: 0
            to: 1
            duration: Appearance.durations.small
            easing.type: Easing.InOutCubic
          }
          NumberAnimation {
            target: list
            property: "scale"
            from: 0.9
            to: 1
            duration: Appearance.durations.small
            easing.type: Easing.InOutCubic
          }
        }
        PropertyAction {
          targets: [list.add, list.remove]
          property: "enabled"
          value: true
        }
      }
    }

    addDisplaced: Transition {
        NumberAnimation {
            property: "y"
            easing.type: Easing.InOutCubic
            duration: Appearance.durations.small
        }
        NumberAnimation {
            properties: "opacity,scale"
            to: 1
            easing.type: Easing.InOutCubic
            duration: Appearance.durations.normal
        }
    }

    displaced: Transition {
      NumberAnimation {
        property: "y"
        easing.type: Easing.InOutCubic
        duration: Appearance.durations.normal
      }
      NumberAnimation {
        properties: "opacity,scale"
        to: 1

        easing.type: Easing.InOutCubic
        duration: Appearance.durations.normal
      }
    }
    ScrollBar.vertical: ScrollBar {
      id: scroll

      implicitWidth: Appearance.spacing.p0
      contentItem: BorderRectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        color: Appearance.srcery.gray3

        MouseArea {
          id: mouse

          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          hoverEnabled: true
          acceptedButtons: Qt.NoButton
        }
      }
    }
  }
}
