// ┌────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░▀█▀░█▀▄░▀█▀░█▀█░█▀█░█▀▀░█░░░█▀▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░░█░░█▀▄░░█░░█▀█░█░█░█░█░█░░░█▀▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░░▀░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>               ├┤
// ││ Repo    : https://github.com/roosta/dotfiles         ││
// ││ Site    : https://www.roosta.sh                      ││
// ├┤ License : GNU General Public License v3              ├┤
// ┆└──────────────────────────────────────────────────────┘┆

pragma ComponentBehavior: Bound
import QtQuick.Shapes
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

  Behavior on y {
    NumberAnimation {
      duration: Style.durations.slow
      easing.type: Easing.InOutQuad
    }
  }

  onWidthChanged:          requestPaint()
  onHeightChanged:         requestPaint()
  onFillColorChanged:      requestPaint()
  onStrokeColorChanged:    requestPaint()
  onGradientEnabledChanged: requestPaint()
  onGradientStartChanged:  requestPaint()
  onGradientEndChanged:    requestPaint()
  onGradientRotationChanged: requestPaint()

  onPaint: {
    const ctx = getContext("2d")
    ctx.clearRect(0, 0, width, height)

    ctx.lineWidth = 1
    const o = ctx.lineWidth / 2

    ctx.beginPath()
    ctx.moveTo(width / 2,     o)
    ctx.lineTo(width - o, height - o)
    ctx.lineTo(o,         height - o)
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
