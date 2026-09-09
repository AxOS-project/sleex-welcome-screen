import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import SleexUiKit.Appearance
import SleexUiKit.Widgets
import SleexUiKit.Functions

Rectangle {
    id: root

    property var stepData: null
    property int currentIndex: 0
    property int totalCount: 1

    property rect targetRect: Qt.rect(0, 0, 0, 0)
    property real screenWidth: 1920
    property real screenHeight: 1080

    signal nextClicked()
    signal prevClicked()
    signal skipClicked()

    implicitWidth: Math.min(440, screenWidth - 40)
    implicitHeight: layoutContainer.implicitHeight + 36

    radius: 20
    color: Appearance.colors.colLayer1

    Behavior on x {
        NumberAnimation { duration: 380; easing.type: Easing.OutQuint }
    }
    Behavior on y {
        NumberAnimation { duration: 380; easing.type: Easing.OutQuint }
    }

    Rectangle {
        anchors.fill: parent
        anchors.margins: -2
        radius: parent.radius + 2
        color: "transparent"
        border.color: ColorUtils.applyAlpha(Appearance.colors.colLayer0Border, 0.5)
        border.width: 1
        z: -1
    }

    function updatePosition() {
        if (!stepData) return;

        var cardW = root.implicitWidth;
        var cardH = root.implicitHeight;
        var pos = stepData.preferredPosition || "bottom";
        var margin = 20;

        var tx = targetRect.x;
        var ty = targetRect.y;
        var tw = targetRect.width;
        var th = targetRect.height;

        var calculatedX = (screenWidth - cardW) / 2;
        var calculatedY = (screenHeight - cardH) / 2;

        if (pos === "bottom" || pos === "bottom-left" || pos === "bottom-right") {
            calculatedY = ty + th + margin;
            if (calculatedY + cardH > screenHeight - margin) {
                // If not enough room below, flip to above target
                calculatedY = ty - cardH - margin;
            }
            if (pos === "bottom-left") calculatedX = tx;
            else if (pos === "bottom-right") calculatedX = tx + tw - cardW;
            else calculatedX = tx + (tw - cardW) / 2;
        } else if (pos === "top" || pos === "top-left" || pos === "top-right") {
            calculatedY = ty - cardH - margin;
            if (calculatedY < margin) {
                calculatedY = ty + th + margin;
            }
            if (pos === "top-left") calculatedX = tx;
            else if (pos === "top-right") calculatedX = tx + tw - cardW;
            else calculatedX = tx + (tw - cardW) / 2;
        } else if (pos === "left") {
            calculatedX = tx - cardW - margin;
            if (calculatedX < margin) {
                calculatedX = tx + tw + margin;
            }
            calculatedY = ty + (th - cardH) / 2;
        } else if (pos === "right") {
            calculatedX = tx + tw + margin;
            if (calculatedX + cardW > screenWidth - margin) {
                calculatedX = tx - cardW - margin;
            }
            calculatedY = ty + (th - cardH) / 2;
        }

        // Clamp inside screen margins
        root.x = Math.max(margin, Math.min(screenWidth - cardW - margin, calculatedX));
        root.y = Math.max(margin, Math.min(screenHeight - cardH - margin, calculatedY));
    }

    onTargetRectChanged: updatePosition()
    onStepDataChanged: updatePosition()
    onScreenWidthChanged: updatePosition()
    onScreenHeightChanged: updatePosition()
    onImplicitHeightChanged: updatePosition()

    Component.onCompleted: updatePosition()

    ColumnLayout {
        id: layoutContainer
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 20
        spacing: 14

        RowLayout {
            Layout.fillWidth: true

            Rectangle {
                implicitWidth: badgeText.implicitWidth + 16
                implicitHeight: 24
                radius: 12
                color: ColorUtils.applyAlpha(Appearance.colors.colPrimary, 0.18)

                StyledText {
                    id: badgeText
                    anchors.centerIn: parent
                    text: "Step " + (root.currentIndex + 1) + " of " + root.totalCount
                    font.pixelSize: 11
                    font.weight: Font.Bold
                    color: Appearance.colors.colPrimary
                }
            }

            Item { Layout.fillWidth: true }

            RippleButton {
                implicitWidth: 28
                implicitHeight: 28
                buttonRadius: 14
                colBackground: "transparent"
                colBackgroundHover: Appearance.colors.colLayer2Hover
                onClicked: root.skipClicked()

                contentItem: MaterialSymbol {
                    anchors.centerIn: parent
                    iconSize: 16
                    text: "close"
                    color: Appearance.colors.colSubtext
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            MaterialSymbol {
                iconSize: 40
                text: root.stepData ? root.stepData.icon : "help_outline"
                color: Appearance.colors.colPrimary
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 2

                StyledText {
                    Layout.fillWidth: true
                    text: root.stepData ? root.stepData.title : ""
                    font.pixelSize: 17
                    font.weight: Font.Bold
                    color: Appearance.colors.colOnLayer1
                }

                StyledText {
                    Layout.fillWidth: true
                    text: root.stepData ? root.stepData.subtitle : ""
                    font.pixelSize: 12
                    color: Appearance.colors.colSubtext
                }
            }
        }

        StyledText {
            Layout.fillWidth: true
            text: root.stepData ? root.stepData.description : ""
            font.pixelSize: 13
            lineHeight: 1.25
            color: Appearance.colors.colOnLayer1Inactive
            wrapMode: Text.WordWrap
        }

        Rectangle {
            Layout.fillWidth: true
            implicitHeight: 28
            radius: 8
            visible: root.stepData && root.stepData.shortcut ? true : false
            color: Appearance.colors.colLayer2

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                spacing: 8

                MaterialSymbol {
                    iconSize: 14
                    text: "key"
                    color: Appearance.colors.colPrimary
                }

                StyledText {
                    Layout.fillWidth: true
                    text: root.stepData ? root.stepData.shortcut : ""
                    font.pixelSize: 11
                    font.weight: Font.Medium
                    color: Appearance.colors.colOnLayer1
                    elide: Text.ElideRight
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            implicitHeight: 1
            color: Appearance.colors.colLayer0Border
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            StepProgressIndicator {
                currentIndex: root.currentIndex
                totalCount: root.totalCount
            }

            Item { Layout.fillWidth: true }

            RippleButtonWithIcon {
                visible: root.currentIndex > 0
                buttonRadius: 16
                colBackground: Appearance.colors.colLayer2
                colBackgroundHover: Appearance.colors.colLayer2Hover
                onClicked: root.prevClicked()
                mainText: "Back"
                materialIcon: "arrow_back"
            }

            RippleButtonWithIcon {
                buttonRadius: 16
                colBackground: Appearance.colors.colPrimary
                colBackgroundHover: ColorUtils.mix(Appearance.colors.colPrimary, "#FFFFFF", 0.15)
                onClicked: root.nextClicked()
                mainText: root.currentIndex === root.totalCount - 1 ? "Finish" : "Next"
                materialIcon: root.currentIndex === root.totalCount - 1 ? "check" : "arrow_forward"
                colText: Appearance.colors.colOnPrimary
            }
        }
    }
}
