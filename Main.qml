import QtQuick
import QtQuick.Controls
import QtQuick.Window

import SleexUiKit.Appearance
import SleexUiKit.Widgets as Widgets
import SleexUiKit.Functions

import "qml/pages"
import "qml/components"
import "qml/data"

Window {
    id: mainWindow
    visible: false
    title: "Sleex Welcome Screen"
    flags: Qt.FramelessWindowHint
    color: "transparent"

    width: Screen.width
    height: Screen.height

    Item {
        id: rootContainer
        anchors.fill: parent
        focus: true

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

            WelcomePage {
                id: welcomeView
                onGetStartedClicked: {
                    rootContainer.currentStageIndex = 1;
                }
                onSkipClicked: {
                    rootContainer.exitApp();
                }
            }

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
