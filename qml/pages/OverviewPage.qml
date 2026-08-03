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

    signal startTourClicked()
    signal backClicked()
    signal skipClicked()

    WaveBackground {
        anchors.fill: parent
        z: 0
    }

    ColumnLayout {
        z: 1
        anchors.centerIn: parent
        width: Math.min(880, parent.width - 60)
        spacing: 28

        RowLayout {
            Layout.fillWidth: true
            spacing: 16

            MaterialSymbol {
                Layout.alignment: Qt.AlignVCenter
                iconSize: 45
                text: "info"
                color: Appearance.colors.colPrimary
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 2

                StyledText {
                    text: "About Sleex Desktop Environment"
                    font.pixelSize: 26
                    font.weight: Font.Bold
                    color: Appearance.colors.colOnLayer1 
                }

                StyledText {
                    text: "Crafted for elegance, efficiency, and seamless Linux productivity"
                    font.pixelSize: 14
                    color: Appearance.colors.colSubtext
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            implicitHeight: overviewColumn.implicitHeight + 40
            radius: 20
            color: Appearance.colors.colLayer2

            ColumnLayout {
                id: overviewColumn
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 24
                spacing: 16

                StyledText {
                    Layout.fillWidth: true
                    text: "Welcome to Sleex, a modern, efficient desktop environment built for speed and aesthetics. Before you do anything else, we recommend taking a quick interactive tour to familiarize yourself with the core features and design philosophy of Sleex."
                    font.pixelSize: 14
                    lineHeight: 1.3
                    color: Appearance.colors.colOnLayer1
                    wrapMode: Text.WordWrap
                }

                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 1
                    color: Appearance.colors.colLayer0Border
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 6

                        RowLayout {
                            spacing: 8
                            MaterialSymbol { iconSize: 18; text: "widgets"; color: Appearance.colors.colPrimary }
                            StyledText { text: "Rich Widgets"; font.weight: Font.Bold; font.pixelSize: 14; color: Appearance.colors.colOnLayer1 }
                        }
                        StyledText {
                            Layout.fillWidth: true
                            text: "Integrated calendar, media controls, audio device router, and notification feeds."
                            font.pixelSize: 12
                            color: Appearance.colors.colSubtext
                            wrapMode: Text.WordWrap
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 6

                        RowLayout {
                            spacing: 8
                            MaterialSymbol { iconSize: 18; text: "auto_awesome"; color: Appearance.colors.colPrimary }
                            StyledText { text: "Adaptive Design"; font.weight: Font.Bold; font.pixelSize: 14; color: Appearance.colors.colOnLayer1 }
                        }
                        StyledText {
                            Layout.fillWidth: true
                            text: "Material Design 3 palette extraction, smooth glassmorphism, and dynamic light/dark theming."
                            font.pixelSize: 12
                            color: Appearance.colors.colSubtext
                            wrapMode: Text.WordWrap
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 6

                        RowLayout {
                            spacing: 8
                            MaterialSymbol { iconSize: 18; text: "tune"; color: Appearance.colors.colPrimary }
                            StyledText { text: "Productivity"; font.weight: Font.Bold; font.pixelSize: 14; color: Appearance.colors.colOnLayer1 }
                        }
                        StyledText {
                            Layout.fillWidth: true
                            text: "Keyboard navigation, multi-monitor support, and a lightweight footprint for fast performance."
                            font.pixelSize: 12
                            color: Appearance.colors.colSubtext
                            wrapMode: Text.WordWrap
                        }
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 14

            RippleButtonWithIcon {
                implicitHeight: 48
                colBackground: Appearance.colors.colLayer2
                colBackgroundHover: Appearance.colors.colLayer2Hover
                onClicked: root.backClicked()
                mainText: "Back"
                materialIcon: "arrow_back"
            }

            RippleButton {
                implicitHeight: 48
                colBackground: "transparent"
                colBackgroundHover: Appearance.colors.colLayer2Hover
                onClicked: root.skipClicked()
                buttonText: "Skip tutorial"
            }

            Item { Layout.fillWidth: true }

            RippleButtonWithIcon {
                implicitHeight: 44
                colBackground: Appearance.colors.colPrimary
                colBackgroundHover: ColorUtils.mix(Appearance.colors.colPrimary, "#FFFFFF", 0.15)
                onClicked: root.startTourClicked()
                materialIcon: "explore"
                mainText: "Start Interactive Tour"
                colText: Appearance.colors.colOnPrimary
            }
        }
    }
}
