cmake_minimum_required(VERSION 3.16)
project(sleex-welcome-screen LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Gui Quick Qml)
find_package(LayerShellQt REQUIRED)

qt_add_executable(sleex-welcome-screen
    src/main.cpp
)

qt_add_qml_module(sleex-welcome-screen
    URI SleexWelcomeScreen
    VERSION 1.0
    QML_FILES
        Main.qml
        qml/pages/WelcomePage.qml
        qml/pages/OverviewPage.qml
        qml/pages/TutorialPage.qml
        qml/components/SleexLogoHeader.qml
        qml/components/StepProgressIndicator.qml
        qml/components/SpotlightScrim.qml
        qml/components/TutorialCalloutCard.qml
        qml/components/WaveBackground.qml
        qml/data/TutorialStepsData.qml
)

target_link_libraries(sleex-welcome-screen PRIVATE
    Qt6::Gui
    Qt6::Quick
    Qt6::Qml
    LayerShellQt::Interface
)

install(TARGETS sleex-welcome-screen DESTINATION bin)
