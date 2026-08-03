import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import SleexUiKit.Appearance
import SleexUiKit.Widgets as Widgets
import SleexUiKit.Functions

import "../components"
import "../data"

Item {
    id: root

    signal tutorialFinished()
    signal skipClicked()

    property int currentStepIndex: 0

    TutorialStepsData {
        id: stepsData
    }

    readonly property var currentStep: stepsData.getStep(currentStepIndex)
    readonly property int totalSteps: stepsData.count
    readonly property bool isCurrentPage: SwipeView.isCurrentItem ?? true

    readonly property rect activeTargetRect: (currentStep && typeof currentStep.calcTargetRect === "function")
        ? currentStep.calcTargetRect(root.width, root.height)
        : Qt.rect(0, 0, 0, 0)

    onIsCurrentPageChanged: {
        if (isCurrentPage) {
            currentStepIndex = 0;
        }
    }

    SpotlightScrim {
        id: scrim
        anchors.fill: parent
        active: root.isCurrentPage
        targetRect: root.activeTargetRect
    }

    TutorialCalloutCard {
        id: calloutCard
        stepData: root.currentStep
        currentIndex: root.currentStepIndex
        totalCount: root.totalSteps
        targetRect: root.activeTargetRect
        screenWidth: root.width
        screenHeight: root.height

        onNextClicked: {
            if (root.currentStepIndex < root.totalSteps - 1) {
                root.currentStepIndex++;
            } else {
                root.tutorialFinished();
            }
        }

        onPrevClicked: {
            if (root.currentStepIndex > 0) {
                root.currentStepIndex--;
            }
        }

        onSkipClicked: {
            root.skipClicked();
        }
    }

    function goNext() {
        if (root.currentStepIndex < root.totalSteps - 1) {
            root.currentStepIndex++;
        } else {
            root.tutorialFinished();
        }
    }

    function goPrev() {
        if (root.currentStepIndex > 0) {
            root.currentStepIndex--;
        }
    }
}
