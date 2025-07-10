import QtQuick
// import QtQuick.Layouts
import qs.services
import qs.config

Text {
  font {
    family: Appearance?.font.family.main ?? "sans-serif"
    pixelSize: Appearance?.font.size.normal ?? 15
  }

  color: Appearance.srcery.brightWhite
  text: Time.time
}
