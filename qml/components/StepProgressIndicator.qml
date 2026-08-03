import QtQuick
import QtQuick.Layouts
import SleexUiKit.Appearance

RowLayout {
    id: root
    property int currentIndex: 0
    property int totalCount: 1
    spacing: 6

    Repeater {
        model: root.totalCount

        Rectangle {
            required property int index

            implicitWidth: index === root.currentIndex ? 24 : 8
            implicitHeight: 8
            radius: 4
            color: index === root.currentIndex ? (Appearance.colors.colPrimary) : (index < root.currentIndex ? (Appearance.colors.colLayer2Hover) : (Appearance.colors.colLayer2))

            Behavior on implicitWidth {
                NumberAnimation { duration: 250; easing.type: Easing.OutQuint }
            }
            Behavior on color {
                ColorAnimation { duration: 200 }
            }
        }
    }
}
