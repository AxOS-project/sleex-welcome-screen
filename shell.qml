//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic

import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls

import SleexUiKit.Appearance
import SleexUiKit.Widgets as Widgets
import SleexUiKit.Functions

import "qml/pages"
import "qml/components"
import "qml/data"

ShellRoot {
    id: root

    Component.onCompleted: {
        Quickshell.execDetached(["hyprctl", "eval", "hl.layer_rule({match = { namespace = 'quickshell:welcome-screen' }, blur = false })"]);
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: mainWindow
            required property var modelData
            screen: modelData

            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.namespace: "quickshell:welcome-screen"
            exclusionMode: ExclusionMode.Ignore
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
            anchors { top: true; bottom: true; left: true; right: true }
            color: "transparent"

            // Root container item for proper Keys event handling and animations
            Item {
                id: rootContainer
                anchors.fill: parent
                focus: true

                // Active application stage index: 0 = Welcome, 1 = Overview, 2 = Tutorial
                property int currentStageIndex: 0

                function exitApp() {
                    fadeOutAnim.start();
                }

                SequentialAnimation {
                    id: fadeOutAnim
                    NumberAnimation {
                        target: rootContainer
                        property: "opacity"
                        to: 0
                        duration: 300
                        easing.type: Easing.InOutQuad
                    }
                    ScriptAction {
                        script: Qt.quit()
                    }
                }

                // Keyboard navigation shortcuts
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Escape) {
                        rootContainer.exitApp();
                        event.accepted = true;
                    } else if (event.key === Qt.Key_Right || event.key === Qt.Key_Space || event.key === Qt.Key_Return) {
                        if (currentStageIndex === 0) {
                            currentStageIndex = 1;
                        } else if (currentStageIndex === 1) {
                            currentStageIndex = 2;
                        } else if (currentStageIndex === 2) {
                            tutorialView.goNext();
                        }
                        event.accepted = true;
                    } else if (event.key === Qt.Key_Left) {
                        if (currentStageIndex === 1) {
                            currentStageIndex = 0;
                        } else if (currentStageIndex === 2) {
                            tutorialView.goPrev();
                        }
                        event.accepted = true;
                    }
                }

                // Smooth SwipeView navigation system (matches Sleex cornerPopup/Dashboard style)
                SwipeView {
                    id: pageSwipeView
                    anchors.fill: parent
                    interactive: false
                    clip: true
                    currentIndex: rootContainer.currentStageIndex

                    Behavior on currentIndex {
                        NumberAnimation {
                            duration: 350
                            easing.type: Easing.InOutCubic
                        }
                    }

                    // Page 0: Welcome Page (Opaque colLayer1 background)
                    WelcomePage {
                        id: welcomeView
                        onGetStartedClicked: {
                            rootContainer.currentStageIndex = 1;
                        }
                        onSkipClicked: {
                            rootContainer.exitApp();
                        }
                    }

                    // Page 1: Sleex Overview Description Page (Opaque colLayer1 background)
                    OverviewPage {
                        id: overviewView
                        onStartTourClicked: {
                            rootContainer.currentStageIndex = 2;
                        }
                        onBackClicked: {
                            rootContainer.currentStageIndex = 0;
                        }
                        onSkipClicked: {
                            rootContainer.exitApp();
                        }
                    }

                    // Page 2: Interactive Scrim Spotlight Tutorial
                    TutorialPage {
                        id: tutorialView
                        onTutorialFinished: {
                            rootContainer.exitApp();
                        }
                        onSkipClicked: {
                            rootContainer.exitApp();
                        }
                    }
                }
            }
        }
    }
}
