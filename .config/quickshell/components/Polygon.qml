pragma ComponentBehavior: Bound
import QtQuick
import qs.config

Canvas {
  id: root
  width: 170
  height: 170

  // 3 = triangle, 4 = square, 5 = pentagon, ...
  property int sides: 5

  // degrees; -90 puts a vertex at the top, like your triangle
  property real _rotation: -90

  property color fillColor: Style.srcery.black
  property color strokeColor: Style.srcery.gray3
  property bool gradientEnabled: false
  property color gradientStart: Style.srcery.gray3
  property color gradientEnd: "transparent"
  property real gradientRotation: 0

  Behavior on y {
    NumberAnimation {
      duration: Style.durations.slow
      easing.type: Easing.InOutQuad
    }
  }

  onWidthChanged:            requestPaint()
  onHeightChanged:           requestPaint()
  onSidesChanged:            requestPaint()
  onRotationChanged:         requestPaint()
  onFillColorChanged:        requestPaint()
  onStrokeColorChanged:      requestPaint()
  onGradientEnabledChanged:  requestPaint()
  onGradientStartChanged:    requestPaint()
  onGradientEndChanged:      requestPaint()
  onGradientRotationChanged: requestPaint()

  onPaint: {
    const ctx = getContext("2d")
    ctx.clearRect(0, 0, width, height)

    ctx.lineWidth = 1
    const n = Math.max(3, sides)
    const cx = width / 2
    const cy = height / 2
    const r = Math.min(width, height) / 2 - ctx.lineWidth / 2
    const offset = _rotation * Math.PI / 180

    ctx.beginPath()
    for (let i = 0; i < n; i++) {
      const a = offset + i * 2 * Math.PI / n
      const x = cx + r * Math.cos(a)
      const y = cy + r * Math.sin(a)
      if (i === 0)
        ctx.moveTo(x, y)
      else
        ctx.lineTo(x, y)
    }
    ctx.closePath()

    ctx.fillStyle = fillColor
    ctx.fill()

    if (gradientEnabled) {
      const rad = gradientRotation * Math.PI / 180
      const len = Math.sqrt(width * width + height * height) / 2
      const grad = ctx.createLinearGradient(
        cx - Math.cos(rad) * len,
        cy - Math.sin(rad) * len,
        cx + Math.cos(rad) * len,
        cy + Math.sin(rad) * len
      )
      grad.addColorStop(0, gradientStart)
      grad.addColorStop(1, gradientEnd)
      ctx.strokeStyle = grad
    } else {
      ctx.strokeStyle = strokeColor
    }

    ctx.stroke()
  }
}
