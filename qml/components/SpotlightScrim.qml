import QtQuick
import QtQuick.Effects
import SleexUiKit.Appearance
import SleexUiKit.Functions

Item {
    id: root
    anchors.fill: parent

    property rect targetRect: Qt.rect(0, 0, 0, 0)
    property bool active: true
    property color scrimColor: ColorUtils.applyAlpha("#0e0e14", 0.78)

    property real animatedX: 0
    property real animatedY: 0
    property real animatedWidth: 0
    property real animatedHeight: 0

    onTargetRectChanged: {
        animatedX = targetRect.x;
        animatedY = targetRect.y;
        animatedWidth = targetRect.width;
        animatedHeight = targetRect.height;
    }

    onActiveChanged: {
        if (active) {
            animatedX = targetRect.x;
            animatedY = targetRect.y;
            animatedWidth = targetRect.width;
            animatedHeight = targetRect.height;
        }
        scrimCanvas.requestPaint();
    }

    Component.onCompleted: {
        animatedX = targetRect.x;
        animatedY = targetRect.y;
        animatedWidth = targetRect.width;
        animatedHeight = targetRect.height;
    }

    Behavior on animatedX {
        NumberAnimation { duration: 400; easing.type: Easing.InOutCubic }
    }
    Behavior on animatedY {
        NumberAnimation { duration: 400; easing.type: Easing.InOutCubic }
    }
    Behavior on animatedWidth {
        NumberAnimation { duration: 400; easing.type: Easing.InOutCubic }
    }
    Behavior on animatedHeight {
        NumberAnimation { duration: 400; easing.type: Easing.InOutCubic }
    }

    onAnimatedXChanged: scrimCanvas.requestPaint()
    onAnimatedYChanged: scrimCanvas.requestPaint()
    onAnimatedWidthChanged: scrimCanvas.requestPaint()
    onAnimatedHeightChanged: scrimCanvas.requestPaint()
    onScrimColorChanged: scrimCanvas.requestPaint()

    Canvas {
        id: scrimCanvas
        anchors.fill: parent
        opacity: root.active ? 1 : 0
        Behavior on opacity {
            NumberAnimation { duration: 350; easing.type: Easing.InOutQuad }
        }

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, width, height);

            if (!root.active) return;

            ctx.fillStyle = root.scrimColor.toString();
            ctx.fillRect(0, 0, width, height);

            if (root.animatedWidth > 0 && root.animatedHeight > 0) {
                ctx.save();
                ctx.globalCompositeOperation = 'destination-out';
                ctx.fillStyle = 'rgba(0, 0, 0, 1.0)';
                ctx.fillRect(root.animatedX, root.animatedY, root.animatedWidth, root.animatedHeight);
                ctx.restore();
            }
        }
    }

    // MouseArea interceptor: allows mouse pass-through inside the spotlight cutout area so users can interact with/hover target desktop elements
    MouseArea {
        anchors.fill: parent
        enabled: root.active
        hoverEnabled: true
        preventStealing: true

        function contains(point) {
            if (!root.active) return false;
            // Exclude spotlight cutout hole from mouse capture to enable hover & interaction on focused UI elements
            if (root.animatedWidth > 0 && root.animatedHeight > 0) {
                if (point.x >= root.animatedX && point.x <= root.animatedX + root.animatedWidth &&
                    point.y >= root.animatedY && point.y <= root.animatedY + root.animatedHeight) {
                    return false;
                }
            }
            return true;
        }

        onClicked: (mouse) => {
            // Absorb click outside callout card and spotlight cutout
        }
    }
}
