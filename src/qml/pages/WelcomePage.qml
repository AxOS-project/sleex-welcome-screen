import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import SleexUiKit.Appearance
import SleexUiKit.Widgets
import SleexUiKit.Functions

import "../components"

Rectangle {
    id: root

    color: Appearance.colors.colLayer0

    signal getStartedClicked()
    signal skipClicked()

    property real headerOpacity: 0
    property real headerYOffset: 30
    property real buttonsOpacity: 0
    property real buttonsYOffset: 25
    property real hintOpacity: 0
    property real bgGlowOpacity: 0

    SequentialAnimation {
        id: entranceAnim
        running: false

        PauseAnimation { duration: 1150 }

        ParallelAnimation {
            NumberAnimation {
                target: root
                property: "bgGlowOpacity"
                from: 0; to: 0.18
                duration: 2200
                easing.type: Easing.OutQuad
            }

            NumberAnimation {
                target: root
                property: "headerOpacity"
                from: 0; to: 1
                duration: 1950
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                target: root
                property: "headerYOffset"
                from: 30; to: 0
                duration: 1950
                easing.type: Easing.OutCubic
            }

            SequentialAnimation {
                PauseAnimation { duration: 1250 }
                ParallelAnimation {
                    NumberAnimation {
                        target: root
                        property: "buttonsOpacity"
                        from: 0; to: 1
                        duration: 850
                        easing.type: Easing.OutCubic
                    }
                    NumberAnimation {
                        target: root
                        property: "buttonsYOffset"
                        from: 25; to: 0
                        duration: 850
                        easing.type: Easing.OutCubic
                    }
                }
            }

            SequentialAnimation {
                PauseAnimation { duration: 1550 }
                NumberAnimation {
                    target: root
                    property: "hintOpacity"
                    from: 0; to: 0.65
                    duration: 800
                    easing.type: Easing.OutQuad
                }
            }
        }
    }

    Component.onCompleted: entranceAnim.start()

    onVisibleChanged: {
        if (visible) {
            headerOpacity = 0;
            headerYOffset = 30;
            buttonsOpacity = 0;
            buttonsYOffset = 25;
            hintOpacity = 0;
            bgGlowOpacity = 0;
            entranceAnim.restart();
        }
    }

    Rectangle {
        width: parent.width * 0.7
        height: parent.height * 0.7
        anchors.centerIn: parent
        radius: width / 2
        opacity: root.bgGlowOpacity
        gradient: Gradient {
            GradientStop { position: 0.0; color: Appearance.colors.colPrimary }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        width: Math.min(840, parent.width - 60)
        spacing: 36

        SleexLogoHeader {
            Layout.alignment: Qt.AlignHCenter
            titleText: "Welcome to Sleex"
            subtitleText: "A sleek, modern, and lightning-fast desktop environment."
            logoScale: 3
            opacity: root.headerOpacity
            transform: Translate { y: root.headerYOffset }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 16
            opacity: root.buttonsOpacity
            transform: Translate { y: root.buttonsYOffset }

            RippleButton {
                implicitHeight: 48
                colBackground: Appearance.colors.colLayer2
                colBackgroundHover: Appearance.colors.colLayer2Hover
                onClicked: root.skipClicked()
                buttonText: "Skip Tutorial"
            }

            RippleButtonWithIcon {
                implicitHeight: 48
                colBackground: Appearance.colors.colPrimary
                colBackgroundHover: ColorUtils.mix(Appearance.colors.colPrimary, "#FFFFFF", 0.15)
                colText: Appearance.colors.colOnPrimary
                onClicked: root.getStartedClicked()
                mainText: "Get Started"
                materialIcon: "arrow_forward"
            }
        }
    }

    // Bottom keyboard navigation hint
    StyledText {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 24
        text: "Press Enter or Space to Get Started  •  Press Esc to Skip"
        font.pixelSize: 12
        color: Appearance.colors.colSubtext
        opacity: root.hintOpacity
    }
}
