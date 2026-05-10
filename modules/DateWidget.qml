import QtQuick
import "../config"
import "."

Item {
    width: 100
    height: Theme.barHeight
    property bool dateHovered: hoverArea.containsMouse

    Timer {
        id: hideTimer
        interval: 300
        onTriggered: {
            if (!parent.dateHovered && !calendarTray.hovered) {
                parent.trayVisible = false
            }
        }
    }

    property bool trayVisible: false

    Text {
        id: dateText

        anchors.verticalCenter: parent.verticalCenter

        color: Theme.barText

        font {
            family: Theme.fontFamily
            pixelSize: 13
            weight: Font.Medium
        }

        Timer {
            interval: 60000
            running: true
            repeat: true
            triggeredOnStart: true

            onTriggered: {
                dateText.text = Qt.formatDateTime(
                    new Date(),
                    "ddd d MMM"
                )
            }
        }
    }

    // Hover area covering the date and left portion
    MouseArea {
        id: hoverArea
        anchors {
            left: parent.left
            leftMargin: -50 // Extend 50px to the left
            right: dateText.right
            top: parent.top
            bottom: parent.bottom
        }
        hoverEnabled: true
        onEntered: parent.trayVisible = true
        onExited: hideTimer.start()
    }

    CalendarTray {
        id: calendarTray
        visible: parent.trayVisible
        z: 10 // Ensure it's above other elements
    }
}

