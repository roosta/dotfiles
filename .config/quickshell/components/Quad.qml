pragma ComponentBehavior: Bound
import QtQuick
import qs.config

Canvas {
  id: root
  width: 170
  height: 150

  property color fillColor: Style.srcery.black
  property color strokeColor: Style.srcery.gray3
  property bool gradientEnabled: false
  property color gradientStart: Style.srcery.gray3
  property color gradientEnd: "transparent"
  property real gradientRotation: 0

  // Corner positions, normalized 0..1 within the canvas bounds.
  // Defaults map to the four corners of a square.
  property point topLeft:     Qt.point(0, 0)
  property point topRight:    Qt.point(1, 0)
  property point bottomRight: Qt.point(1, 1)
  property point bottomLeft:  Qt.point(0, 1)

  Behavior on y {
    NumberAnimation {
      duration: Style.durations.slow
      easing.type: Easing.InOutQuad
    }
  }

  onWidthChanged:            requestPaint()
  onHeightChanged:           requestPaint()
  onFillColorChanged:        requestPaint()
  onStrokeColorChanged:      requestPaint()
  onGradientEnabledChanged:  requestPaint()
  onGradientStartChanged:    requestPaint()
  onGradientEndChanged:      requestPaint()
  onGradientRotationChanged: requestPaint()
  onTopLeftChanged:          requestPaint()
  onTopRightChanged:         requestPaint()
  onBottomRightChanged:      requestPaint()
  onBottomLeftChanged:       requestPaint()

  onPaint: {
    const ctx = getContext("2d")
    ctx.clearRect(0, 0, width, height)

    ctx.lineWidth = 1
    const o = ctx.lineWidth / 2

    // Map a normalized point into the drawable area, insetting by the
    // stroke offset so the 1px line isn't clipped at the edges.
    const map = p => Qt.point(
      o + p.x * (width  - 2 * o),
      o + p.y * (height - 2 * o)
    )

    const tl = map(topLeft)
    const tr = map(topRight)
    const br = map(bottomRight)
    const bl = map(bottomLeft)

    ctx.beginPath()
    ctx.moveTo(tl.x, tl.y)
    ctx.lineTo(tr.x, tr.y)
    ctx.lineTo(br.x, br.y)
    ctx.lineTo(bl.x, bl.y)
    ctx.closePath()

    ctx.fillStyle = fillColor
    ctx.fill()

    if (gradientEnabled) {
      const rad = gradientRotation * Math.PI / 180
      const len = Math.sqrt(width * width + height * height) / 2
      const grad = ctx.createLinearGradient(
        width / 2 - Math.cos(rad) * len,
        height / 2 - Math.sin(rad) * len,
        width / 2 + Math.cos(rad) * len,
        height / 2 + Math.sin(rad) * len
      )
      grad.addColorStop(0, gradientStart)
      grad.addColorStop(1, gradientEnd)
      ctx.strokeStyle = grad
    } else {
      ctx.strokeStyle = strokeColor
    }

    ctx.lineWidth = 1
    ctx.stroke()
  }
}
