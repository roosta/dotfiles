// Generated from SVG file $HOME/.assets/glyph.svg
import QtQuick
import QtQuick.VectorImage
import QtQuick.VectorImage.Helpers
import QtQuick.Shapes

Item {
  implicitWidth: 400
  implicitHeight: 400
  component AnimationsInfo : QtObject
  {
    property bool paused: false
    property int loops: 1
    signal restart()
  }
  property AnimationsInfo animations : AnimationsInfo {}
  transform: [
    Scale { xScale: root.width / 400; yScale: root.height / 400 }
  ]
  objectName: "svg32"
  id: root
  Shape {
    objectName: "star"
    preferredRendererType: Shape.CurveRenderer
    id: _qt_node1
    transform: TransformGroup {
      id: _qt_node1_transform_base_group
      Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(2.33764, 0, 0, 2.33764, -107.772, -19.8136)}
    }
    ShapePath {
      id: _qt_shapePath_0
      objectName: "svg_path:path2"
      strokeColor: "transparent"
      fillColor: "#ffc5b088"
      fillRule: ShapePath.WindingFill
      PathSvg { path: "M 49.0568 128.247 L 86.9552 94.0323 L 49.0568 59.8172 L 100.049 62.4217 L 97.4443 11.4298 L 131.659 49.3281 L 165.874 11.4298 L 163.27 62.4217 L 214.262 59.8172 L 176.364 94.0323 L 214.262 128.247 L 163.27 125.643 L 165.874 176.635 L 131.659 138.736 L 97.4443 176.635 L 100.049 125.643 L 49.0568 128.247 " }
    }
    ShapePath {
      id: _qt_shapePath_1
      objectName: "svg_path:shade"
      strokeColor: "transparent"
      fillColor: "#fffce8c3"
      fillRule: ShapePath.WindingFill
      PathSvg { path: "M 165.874 11.4298 L 163.991 15.4403 C 161.578 31.0549 156.557 56.7583 152.961 75.9234 C 155.385 76.8634 157.457 77.7928 159.087 78.9477 L 203.432 65.0724 C 190.081 74.5582 181.258 83.8757 169.599 94.0318 C 169.935 96.8684 170.004 99.143 169.599 101.295 L 208.731 127.964 L 214.263 128.246 L 176.364 94.0318 L 214.263 59.8166 L 163.27 62.4207 L 165.874 11.4298 " }
    }
  }
  Item { // Structure node
    objectName: "eye"
    id: _qt_node2
    transform: TransformGroup {
      id: _qt_node2_transform_base_group
      Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(2.33764, 0, 0, 2.33764, -107.772, -19.8136)}
    }
    Item {
      objectName: "use2"
      id: _qt_node3
      Shape {

        preferredRendererType: Shape.CurveRenderer
        objectName: "eyeShape"
        id: _qt_node4
        ShapePath {
          id: _qt_shapePath_2
          objectName: "svg_path:eyeShape"
          strokeColor: "transparent"
          fillColor: "#ff121110"
          fillRule: ShapePath.WindingFill
          PathSvg { path: "M 131.657 82.3711 C 117.768 82.3752 104.713 87.7904 96.5087 96.9507 C 104.713 106.111 117.767 111.527 131.657 111.531 C 145.549 111.527 158.607 106.108 166.81 96.9432 C 158.603 87.7844 145.546 82.3719 131.657 82.3711 " }
        }
      }
    }
    Shape {
      objectName: "eyeball"

      preferredRendererType: Shape.CurveRenderer
      id: _qt_node5
      ShapePath {
        id: _qt_shapePath_3
        objectName: "svg_path:circle3"
        strokeColor: "transparent"
        fillColor: "#fffce8c3"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 143.266 96.9512 C 143.266 103.361 138.069 108.558 131.659 108.558 C 125.249 108.558 120.053 103.361 120.053 96.9512 C 120.053 90.5411 125.249 85.3446 131.659 85.3446 C 138.069 85.3446 143.266 90.5411 143.266 96.9512 " }
      }
      ShapePath {
        id: _qt_shapePath_4
        objectName: "svg_path:circle4"
        strokeColor: "transparent"
        fillColor: "#ff121110"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 126.942 95.8507 C 126.863 96.2122 126.823 96.5811 126.823 96.9511 C 126.823 99.8033 129.135 102.116 131.987 102.116 C 134.84 102.115 137.152 99.8033 137.152 96.9511 C 137.152 94.0989 134.84 91.7868 131.987 91.7868 C 131.962 91.7868 131.937 91.7871 131.912 91.7875 C 132.462 92.3556 132.766 93.0947 132.767 93.8613 C 132.767 95.5677 131.289 96.9512 129.467 96.9511 C 128.493 96.9513 127.569 96.5485 126.942 95.8507 L 126.942 95.8507 " }
      }
    }
    Shape {

      preferredRendererType: Shape.CurveRenderer
      objectName: "topRidge"
      id: _qt_node6
      transform: TransformGroup {
        id: _qt_node6_transform_base_group
        Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(2.83106, 0, 0, 2.83106, -241.631, -172.178)}
      }
      ShapePath {
        id: _qt_shapePath_5
        objectName: "svg_path:topRidge"
        strokeColor: "#ff121110"
        strokeWidth: 0.529167
        capStyle: ShapePath.FlatCap
        joinStyle: ShapePath.MiterJoin
        miterLimit: 4
        fillColor: "#00000000"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 119.077 92.5431 C 119.077 92.5431 130.755 82.0048 144.642 92.6719 " }
      }
    }
    Shape {
      objectName: "bottomRidge"

      preferredRendererType: Shape.CurveRenderer
      id: _qt_node7
      ShapePath {
        id: _qt_shapePath_6
        objectName: "svg_path:bottomRidge"
        strokeColor: "#ff121110"
        strokeWidth: 1.49809
        capStyle: ShapePath.FlatCap
        joinStyle: ShapePath.MiterJoin
        miterLimit: 4
        fillColor: "#00000000"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 95.4938 104.164 C 95.4938 104.164 128.555 133.998 167.87 103.799 " }
      }
    }
    Shape {
      objectName: "lashes"
      preferredRendererType: Shape.CurveRenderer
      id: _qt_node8
      transform: TransformGroup {
        id: _qt_node8_transform_base_group
        Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(2.83106, 0, 0, 2.83106, -241.631, -172.178)}
      }
      ShapePath {
        id: _qt_shapePath_7
        objectName: "svg_path:lashes"
        strokeColor: "transparent"
        fillColor: "#ff121110"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 119.77 64.8551 L 119.786 65.1653 L 127.915 88.3453 L 128.893 88.1437 L 119.975 65.0827 L 119.77 64.8551 M 143.941 64.8551 L 143.736 65.0827 L 134.818 88.1437 L 135.796 88.3453 L 143.925 65.1653 L 143.941 64.8551 M 102.678 81.9466 L 102.909 82.1549 L 120.712 91.3243 L 121.908 90.5791 L 102.985 81.9623 L 102.678 81.9466 M 161.033 81.9466 L 160.727 81.9623 L 141.803 90.5791 L 142.999 91.3243 L 160.802 82.1549 L 161.033 81.9466 " }
      }
    }
  }
  Item { // Structure node
    objectName: "gems"
    id: _qt_node9
    transform: TransformGroup {
      id: _qt_node9_transform_base_group
      Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(6.61799, 0, 0, 6.61799, -671.32, -422.305)}
    }
    Shape {
      objectName: "blue"
      preferredRendererType: Shape.CurveRenderer
      id: _qt_node10
      transform: TransformGroup {
        id: _qt_node10_transform_base_group
        Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(1.43004, 1.43004, -1.43004, 1.43004, 232.326, -171.073)}
      }
      ShapePath {
        id: _qt_shapePath_8
        objectName: "svg_path:path15"
        strokeColor: "transparent"
        fillColor: "#ff68a8e4"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 57.4945 119.154 L 55.2691 116.05 L 57.4945 112.946 " }
      }
      ShapePath {
        id: _qt_shapePath_9
        objectName: "svg_path:path16"
        strokeColor: "transparent"
        fillColor: "#ff2c78bf"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 57.4945 112.946 L 59.7199 116.05 L 57.4945 119.154 " }
      }
    }
    Shape {
      objectName: "magenta"
      preferredRendererType: Shape.CurveRenderer
      id: _qt_node11
      transform: TransformGroup {
        id: _qt_node11_transform_base_group
        Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(2.02238, 0, 0, 2.02238, 15.3836, -164.608)}
      }
      ShapePath {
        id: _qt_shapePath_10
        objectName: "svg_path:path17"
        strokeColor: "transparent"
        fillColor: "#ffe02c6d"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 57.4945 119.154 L 55.2691 116.05 L 57.4945 112.946 " }
      }
      ShapePath {
        id: _qt_shapePath_11
        objectName: "svg_path:path18"
        strokeColor: "transparent"
        fillColor: "#ffff5c8f"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 57.4945 112.946 L 59.7199 116.05 L 57.4945 119.154 " }
      }
    }
    Shape {
      objectName: "cyan"
      preferredRendererType: Shape.CurveRenderer
      id: _qt_node12
      transform: TransformGroup {
        id: _qt_node12_transform_base_group
        Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(1.43004, -1.43004, 1.43004, 1.43004, -133.446, -6.63432)}
      }
      ShapePath {
        id: _qt_shapePath_12
        objectName: "svg_path:path19"
        strokeColor: "transparent"
        fillColor: "#ff0aaeb3"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 57.4945 119.154 L 55.2691 116.05 L 57.4945 112.946 " }
      }
      ShapePath {
        id: _qt_shapePath_13
        objectName: "svg_path:path20"
        strokeColor: "transparent"
        fillColor: "#ff2be4d0"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 57.4945 112.946 L 59.7199 116.05 L 57.4945 119.154 " }
      }
    }
    Shape {
      objectName: "white"
      preferredRendererType: Shape.CurveRenderer
      id: _qt_node13
      transform: TransformGroup {
        id: _qt_node13_transform_base_group
        Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(0, -2.02238, 2.02238, 0, -126.981, 210.308)}
      }
      ShapePath {
        id: _qt_shapePath_14
        objectName: "svg_path:path21"
        strokeColor: "transparent"
        fillColor: "#ffc5b088"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 57.4945 119.154 L 55.2691 116.05 L 57.4945 112.946 " }
      }
      ShapePath {
        id: _qt_shapePath_15
        objectName: "svg_path:path22"
        strokeColor: "transparent"
        fillColor: "#fffce8c3"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 57.4945 112.946 L 59.7199 116.05 L 57.4945 119.154 " }
      }
    }
    Shape {
      objectName: "orange"
      preferredRendererType: Shape.CurveRenderer
      id: _qt_node14
      transform: TransformGroup {
        id: _qt_node14_transform_base_group
        Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(-1.43004, -1.43004, 1.43004, -1.43004, 30.9926, 359.138)}
      }
      ShapePath {
        id: _qt_shapePath_16
        objectName: "svg_path:path23"
        strokeColor: "transparent"
        fillColor: "#ffff8700"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 57.4945 119.154 L 55.2691 116.05 L 57.4945 112.946 " }
      }
      ShapePath {
        id: _qt_shapePath_17
        objectName: "svg_path:path24"
        strokeColor: "transparent"
        fillColor: "#ffff5f00"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 57.4945 112.946 L 59.7199 116.05 L 57.4945 119.154 " }
      }
    }
    Shape {
      objectName: "red"
      preferredRendererType: Shape.CurveRenderer
      id: _qt_node15
      transform: TransformGroup {
        id: _qt_node15_transform_base_group
        Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(-2.02238, 0, 0, -2.02238, 247.935, 352.672)}
      }
      ShapePath {
        id: _qt_shapePath_18
        objectName: "svg_path:path25"
        strokeColor: "transparent"
        fillColor: "#fff75341"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 57.4945 119.154 L 55.2691 116.05 L 57.4945 112.946 " }
      }
      ShapePath {
        id: _qt_shapePath_19
        objectName: "svg_path:path26"
        strokeColor: "transparent"
        fillColor: "#ffef2f27"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 57.4945 112.946 L 59.7199 116.05 L 57.4945 119.154 " }
      }
    }
    Shape {
      objectName: "green"
      preferredRendererType: Shape.CurveRenderer
      id: _qt_node16
      transform: TransformGroup {
        id: _qt_node16_transform_base_group
        Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(-1.43004, 1.43004, -1.43004, -1.43004, 396.765, 194.699)}
      }
      ShapePath {
        id: _qt_shapePath_20
        objectName: "svg_path:path27"
        strokeColor: "transparent"
        fillColor: "#ff98bc37"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 57.4945 119.154 L 55.2691 116.05 L 57.4945 112.946 " }
      }
      ShapePath {
        id: _qt_shapePath_21
        objectName: "svg_path:path28"
        strokeColor: "transparent"
        fillColor: "#ff519f50"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 57.4945 112.946 L 59.7199 116.05 L 57.4945 119.154 " }
      }
    }
    Shape {
      objectName: "yellow"
      preferredRendererType: Shape.CurveRenderer
      id: _qt_node17
      transform: TransformGroup {
        id: _qt_node17_transform_base_group
        Matrix4x4 { matrix: PlanarTransform.fromAffineMatrix(0, 2.02238, -2.02238, 0, 390.299, -22.2435)}
      }
      ShapePath {
        id: _qt_shapePath_22
        objectName: "svg_path:path29"
        strokeColor: "transparent"
        fillColor: "#fffed06e"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 57.4945 119.154 L 55.2691 116.05 L 57.4945 112.946 " }
      }
      ShapePath {
        id: _qt_shapePath_23
        objectName: "svg_path:path30"
        strokeColor: "transparent"
        fillColor: "#fffbb829"
        fillRule: ShapePath.WindingFill
        PathSvg { path: "M 57.4945 112.946 L 59.7199 116.05 L 57.4945 119.154 " }
      }
    }
  }
}
