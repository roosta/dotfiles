pragma ComponentBehavior: Bound
import QtQuick.Shapes
import QtQuick
import qs.config

Shape {
  id: root
  anchors.horizontalCenter: parent.horizontalCenter
  width: 170
  height: 150

  Behavior on y {
    NumberAnimation {
      duration: Appearance.durations.slow
      easing.type: Easing.InOutQuad
    }
  }

  ShapePath {
    strokeWidth: 1
    id: path
    strokeColor: Appearance.srcery.gray3
    fillColor: Appearance.srcery.black
    PathSvg {
      id: svg
      path: `M ${root.width * 0.5} 0
      L ${root.width} ${root.height}
      L 0 ${root.height} Z`
    }
  }
}
