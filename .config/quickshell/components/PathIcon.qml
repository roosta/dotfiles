import QtQuick
import Quickshell
import QtQuick.VectorImage
// import Quickshell.Widgets
// import Qt5Compat.GraphicalEffects

Item {
  id: root
  property string source: ""
  property string iconFolder: Qt.resolvedUrl(Quickshell.shellPath("assets/icons"))  // The folder to check first
  width: 30
  height: 30

  VectorImage {
    id: vectorImage
    anchors.fill: parent
    fillMode: VectorImage.PreserveAspectFit
    source: {
      const fullPathWhenSourceIsIconName = root.iconFolder + "/" + root.source;
      if (root.iconFolder && fullPathWhenSourceIsIconName) {
        return fullPathWhenSourceIsIconName
      }
      return root.source
    }
  }
}
