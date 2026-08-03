import QtQuick
import QtQuick.Layouts
import SleexUiKit.Appearance
import SleexUiKit.Widgets
import SleexUiKit.Functions

ColumnLayout {
    id: root
    spacing: 20

    property string titleText: "Welcome to Sleex"
    property string subtitleText: "The Next-Generation Linux Desktop Environment"
    property real logoScale: 1.0

    Rectangle {
        Layout.alignment: Qt.AlignHCenter
        implicitWidth: 80 * logoScale
        implicitHeight: 80 * logoScale
        color: "transparent"

        Image {
            anchors.fill: parent
            source: "file:///usr/share/pixmaps/sleex/svg/dark.svg"
            fillMode: Image.PreserveAspectFit
        }
    }

    StyledText {
        Layout.alignment: Qt.AlignHCenter
        text: root.titleText
        font.pixelSize: 42
        font.weight: Font.Bold
        color: Appearance.colors ? Appearance.colors.colOnLayer1 : "#FFFFFF"
        horizontalAlignment: Text.AlignHCenter
    }

    StyledText {
        Layout.alignment: Qt.AlignHCenter
        text: root.subtitleText
        font.pixelSize: 15
        color: Appearance.colors ? Appearance.colors.colSubtext : "#A0A0B0"
        horizontalAlignment: Text.AlignHCenter
    }
}
