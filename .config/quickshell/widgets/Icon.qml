import qs.services
import qs.config
import QtQuick

Text {
  required property string className
  font {
    family: Appearance.font.family.symbols
    pointSize: Appearance.font.size.normal
  }
  text: className
  color: Appearance.srcery.brightWhite
}
