import QtQuick
// import QtQuick.Layouts
import qs.services
import qs.config

Item {
  implicitWidth: childrenRect.width + Appearance.spacing.p2
  implicitHeight: Appearance.bar.height
  Text {
    anchors.verticalCenter: parent.verticalCenter
    font {
      family: Appearance.font.extraLight
      pixelSize: 24
    }

    color: Appearance.srcery.white
    text: Time.time
  }}
