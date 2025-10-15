import QtQuick
import QtQuick.Layouts
import qs.services
import qs.config

Item {
  implicitWidth: childrenRect.width + Appearance.spacing.p2
  implicitHeight: Appearance.bar.height
  ColumnLayout {
    anchors.verticalCenter: parent.verticalCenter
    spacing: -4
    Text {
      Layout.alignment: Qt.AlignRight
      font {
        family: Appearance.font.light
        pixelSize: Appearance.font.size2
      }

      color: Appearance.srcery.brightWhite
      text: Time.time
    }
    Text {
      Layout.alignment: Qt.AlignRight
      font {
        family: Appearance.font.extraLight
        pixelSize: Appearance.font.size2
      }

      color: Appearance.srcery.white
      text: Time.date
    }
  }

}
