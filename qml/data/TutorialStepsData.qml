import QtQuick

QtObject {
    id: root

    readonly property list<QtObject> steps: [
        QtObject {
            property string id: "bar"
            property string title: "Top System Bar"
            property string icon: "space_dashboard"
            property string subtitle: "Status & Quick Controls"
            property string description: "The Top Bar spans the top edge of your screen. It hosts workspace management, active window titles, system tray indicators, and quick settings toggles."
            property string shortcut: "Click indicators or scroll on bar"
            property var calcTargetRect: function(w, h) {
                return Qt.rect(0, 0, w, 48)
            }
            property string preferredPosition: "bottom"
        },
        QtObject {
            property string id: "workspaces"
            property string title: "Workspace Switcher & App launcher"
            property string icon: "grid_view"
            property string subtitle: "Centered Desktop Navigation"
            property string description: "Positioned at the top-center of the bar, the Workspace Switcher displays active virtual desktops. Right click on it to open the app launcher and quickly search for installed applications."
            property string shortcut: "Super + 1..9  •  Super + Scroll"
            property var calcTargetRect: function(w, h) {
                var barW = Math.min(320, w * 0.3);
                return Qt.rect((w - barW) / 2, 0, barW, 48)
            }
            property string preferredPosition: "bottom"
        },
        QtObject {
            property string id: "systray"
            property string title: "System Tray & Quick Controls"
            property string icon: "tune"
            property string subtitle: "Hardware Status & Toggles"
            property string description: "Located on the top-right of the bar. Provides immediate access to system tray and status icons, such as volume, battery, bluetooth and network controls."
            property string shortcut: "Click on icons to open the dashboard"
            property var calcTargetRect: function(w, h) {
                var trayW = Math.min(360, w * 0.35);
                return Qt.rect(w - trayW - 8, 0, trayW, 48)
            }
            property string preferredPosition: "bottom-right"
        },
        QtObject {
            property string id: "dock"
            property string title: "Application Dock"
            property string icon: "apps"
            property string subtitle: "App Launcher & Active Windows"
            property string description: "The floating Application Dock is anchored at the bottom-center of the desktop. Hover your mouse at the bottom edge to reveal your pinned apps and running windows."
            property string shortcut: "Hover on the bottom edge of the screen to reveal dock"
            property var calcTargetRect: function(w, h) {
                var dockW = Math.min(620, w - 80);
                var dockH = 84;
                return Qt.rect((w - dockW) / 2, h - dockH, dockW, dockH)
            }
            property string preferredPosition: "top"
        },
        QtObject {
            property string id: "cornerPopup"
            property string title: "Bottom-Left Widget Drawer"
            property string icon: "widgets"
            property string subtitle: "Utilities ready at your fingertips"
            property string description: "Anchored at the bottom-left corner of the screen. Move your cursor to the bottom-left corner to trigger and reveal utility widgets like Pomodoro and Stopwatch."
            property string shortcut: "Move cursor to bottom-left corner"
            property var calcTargetRect: function(w, h) {
                var popupW = Math.min(500, w * 0.4);
                var popupH = Math.min(350, h * 0.45);
                return Qt.rect(0, h - popupH, popupW + 12, popupH)
            }
            property string preferredPosition: "top-left"
        },
        QtObject {
            property string id: "dashboard"
            property string title: "Sleex Dashboard"
            property string icon: "dashboard"
            property string subtitle: "Full Sidebar & Notification Center"
            property string description: "The Dashboard slides in from the edge of your screen. It integrates your desktop calendar, notifications feed, todo checklist, and media player controls."
            property string shortcut: "Super + D  •  Click right side of the Bar"
            property var calcTargetRect: function(w, h) {
                var dashW = 1500;
                var dashH = 900;
                return Qt.rect((w - dashW) / 2, (h - dashH) / 2, dashW, dashH)
            }
            property string preferredPosition: "left"
        },
        QtObject {
            property string id: "wallpaper"
            property string title: "Wallpaper Selector"
            property string icon: "wallpaper"
            property string subtitle: "Top Desktop Customization Panel"
            property string description: "The Wallpaper Selector opens across the top of the desktop. Browse wallpapers, generate Material 3 color palettes automatically, and customize desktop visuals."
            property string shortcut: "Super + T"
            property var calcTargetRect: function(w, h) {
                return Qt.rect(16, 52, w - 32, 210)
            }
            property string preferredPosition: "bottom"
        },
        QtObject {
            property string id: "cheatsheet"
            property string title: "Keyboard Shortcuts Cheatsheet"
            property string icon: "keyboard"
            property string subtitle: "Centered Keybinding Reference"
            property string description: "The Cheatsheet modal opens right in the center of your screen. Press Super + F1 anytime to view all active window management keybindings and shortcuts."
            property string shortcut: "Super + F1"
            property var calcTargetRect: function(w, h) {
                var cheatW = 1050;
                var cheatH = 950;
                return Qt.rect((w - cheatW) / 2, (h - cheatH) / 2, cheatW, cheatH)
            }
            property string preferredPosition: "bottom"
        },
        QtObject {
            property string id: "background"
            property string title: "Desktop Background & Ambient Clock"
            property string icon: "schedule"
            property string subtitle: "Ambient Desktop Surface"
            property string description: "The ambient desktop background displays your wallpaper, quotes, informations about Sleex and central desktop clock."
            property string shortcut: "Right click on the clock to move it or change it's scale"
            property var calcTargetRect: function(w, h) {
                var bgW = Math.min(460, w * 0.35);
                var bgH = Math.min(240, h * 0.3);
                return Qt.rect((w - bgW) / 2, (h - bgH) / 2 - 30, bgW, bgH)
            }
            property string preferredPosition: "bottom"
        },
        QtObject {
            property string id: "finish"
            property string title: "Tutorial Complete!"
            property string icon: "check_circle"
            property string subtitle: "Welcome to Sleex"
            property string description: "You are all set to use Sleex Desktop Environment. Customization, speed, and elegance are at your fingertips. Click Finish to close this tutorial and enjoy your desktop!"
            property string shortcut: "Enjoy Sleex Desktop!"
            property var calcTargetRect: function(w, h) {
                var modalW = Math.min(560, w - 60);
                var modalH = Math.min(360, h - 80);
                return Qt.rect((w - modalW) / 2, (h - modalH) / 2, modalW, modalH)
            }
            property string preferredPosition: "center"
        }
    ]

    readonly property int count: steps.length

    function getStep(index) {
        if (index >= 0 && index < steps.length) {
            return steps[index];
        }
        return null;
    }
}
