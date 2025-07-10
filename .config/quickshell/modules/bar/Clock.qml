import QtQuick
// import QtQuick.Layouts
import "../../services"
import "../../config"

Text {
  font {
    family: Appearance?.font.family.main ?? "sans-serif"
    pixelSize: Appearance?.font.size.normal ?? 15
  }

  color: Appearance?.color.srcery.brightWhite
  text: Time.time
}
