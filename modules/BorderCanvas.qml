import QtQuick
import "../config"

Canvas {
    anchors.fill: parent
    antialiasing: true

    onPaint: {
        var ctx = getContext("2d")
        ctx.clearRect(0, 0, width, height)

        var t  = Theme.borderThickness
        var r  = Theme.borderRadius
        var b  = Theme.barHeight
        var w  = width
        var h  = height
        var ir = Math.max(0, r - t)

        ctx.fillStyle = Theme.borderColor

        ctx.beginPath()

        // outer
        ctx.moveTo(0, 0)
        ctx.lineTo(w, 0)
        ctx.lineTo(w, h)
        ctx.lineTo(0, h)
        ctx.lineTo(0, 0)

        // inner
        ctx.moveTo(t, b)
        ctx.lineTo(t, h - t - ir)
        ctx.arcTo(t, h - t, t + ir, h - t, ir)

        ctx.lineTo(w - t - ir, h - t)
        ctx.arcTo(w - t, h - t, w - t, h - t - ir, ir)

        ctx.lineTo(w - t, b + ir)
        ctx.arcTo(w - t, b, w - t - ir, b, ir)

        ctx.lineTo(t + ir, b)
        ctx.arcTo(t, b, t, b + ir, ir)

        ctx.fill("evenodd")
    }
}
