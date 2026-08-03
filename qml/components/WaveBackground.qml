import QtQuick
import SleexUiKit.Appearance
import SleexUiKit.Functions

Item {
    id: root
    anchors.fill: parent

    property real phase: 0.0
    property color primaryColor: Appearance.colors.colSecondaryContainer

    Timer {
        interval: 16
        running: root.visible
        repeat: true
        onTriggered: {
            root.phase += 0.02;
            waveCanvas.requestPaint();
        }
    }

    Canvas {
        id: waveCanvas
        anchors.fill: parent
        antialiasing: true

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            var w = width;
            var h = height;
            var midY = h * 0.48;
            var p = root.phase;

            if (w <= 0 || h <= 0) return;

            var gradBack = ctx.createLinearGradient(0, midY - 30, 0, h);
            gradBack.addColorStop(0.0, ColorUtils.applyAlpha(root.primaryColor, 0.12).toString());
            gradBack.addColorStop(0.5, ColorUtils.applyAlpha(root.primaryColor, 0.05).toString());
            gradBack.addColorStop(1.0, "transparent");

            ctx.beginPath();
            ctx.moveTo(0, h);
            for (var x = 0; x <= w; x += 12) {
                var yBack = midY + Math.sin(x * 0.004 + p * 0.7) * 30 + Math.cos(x * 0.002 - p * 0.4) * 18;
                ctx.lineTo(x, yBack);
            }
            ctx.lineTo(w, h);
            ctx.closePath();
            ctx.fillStyle = gradBack;
            ctx.fill();

            var gradMid = ctx.createLinearGradient(0, midY - 15, 0, h);
            gradMid.addColorStop(0.0, ColorUtils.applyAlpha(root.primaryColor, 0.18).toString());
            gradMid.addColorStop(0.6, ColorUtils.applyAlpha(root.primaryColor, 0.06).toString());
            gradMid.addColorStop(1.0, "transparent");

            ctx.beginPath();
            ctx.moveTo(0, h);
            for (var x = 0; x <= w; x += 12) {
                var yMid = midY + Math.sin(x * 0.005 + p) * 25 + Math.sin(x * 0.003 - p * 0.6) * 15;
                ctx.lineTo(x, yMid);
            }
            ctx.lineTo(w, h);
            ctx.closePath();
            ctx.fillStyle = gradMid;
            ctx.fill();

            var gradFront = ctx.createLinearGradient(0, midY, 0, h);
            gradFront.addColorStop(0.0, ColorUtils.applyAlpha(root.primaryColor, 0.25).toString());
            gradFront.addColorStop(0.4, ColorUtils.applyAlpha(root.primaryColor, 0.08).toString());
            gradFront.addColorStop(1.0, "transparent");

            ctx.beginPath();
            ctx.moveTo(0, h);
            for (var x = 0; x <= w; x += 10) {
                var yFront = midY + Math.sin(x * 0.006 + p * 1.2) * 20 + Math.cos(x * 0.004 + p * 0.8) * 12;
                ctx.lineTo(x, yFront);
            }
            ctx.lineTo(w, h);
            ctx.closePath();
            ctx.fillStyle = gradFront;
            ctx.fill();
        }
    }
}
