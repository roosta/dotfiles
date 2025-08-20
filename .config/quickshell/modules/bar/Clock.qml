import QtQuick
// import QtQuick.Layouts
import qs.services
import qs.config

Text {
  font {
    family: Appearance.font.main
    pixelSize: Appearance.font.size2
  }

  color: Appearance.srcery.brightWhite
  text: Time.time
}
