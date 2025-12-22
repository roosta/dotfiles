import QtQuick
import QtQuick.Layouts
import qs.services
import qs.config
import qs.components

BorderRectangle {
  implicitWidth: childrenRect.width
  implicitHeight: Appearance.bar.height - Appearance.bar.borderWidth
  // topBorder: Appearance.bar.borderWidth
  rightBorder: Appearance.bar.borderWidth
  Layout.topMargin: Appearance.bar.borderWidth
  borderColor: Appearance.srcery.gray3
  color: Appearance.srcery.black
  Rectangle {
    implicitWidth: childrenRect.width + Appearance.spacing.p1
    implicitHeight: parent.height
    color: "transparent"
    ColumnLayout {
      implicitHeight: Appearance.bar.height - Appearance.spacing.p1 * 2
      spacing: -4
      anchors.verticalCenter: parent.verticalCenter
      Text {
        Layout.alignment: Qt.AlignRight
        font {
          family: Appearance.font.light
          pointSize: Appearance.font.normal
        }

        color: Appearance.srcery.brightWhite
        text: Time.time
      }
      Text {
        Layout.alignment: Qt.AlignRight
        font {
          family: Appearance.font.light
          pointSize: Appearance.font.small
        }

        color: Appearance.srcery.white
        text: Time.date
      }
    }
  }

}
