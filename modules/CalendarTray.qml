import QtQuick
import "../config"

Item {
    id: calendarTray

    width: 300
    height: 250

    // Position it at the top left, below the bar
    x: 0
    y: visible ? Theme.barHeight : -height

    Behavior on y {
        NumberAnimation {
            duration: 100
            easing.type: Easing.OutQuad
        }
    }

    // Background with border color and transparency
    Rectangle {
        anchors.fill: parent
        color: Theme.borderColor
        radius: Theme.borderRadius
    }

    // Simple calendar display
    Column {
        anchors.centerIn: parent
        spacing: 10

        Text {
            text: Qt.formatDateTime(new Date(), "MMMM yyyy")
            color: "white"
            font.pixelSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Grid {
            columns: 7
            spacing: 5
            anchors.horizontalCenter: parent.horizontalCenter

            // Day headers
            Repeater {
                model: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
                Text {
                    text: modelData
                    color: "#aaaaaa"
                    font.pixelSize: 12
                    width: 30
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            // Days - simplified, just show current month days
            Repeater {
                model: 31
                Text {
                    text: index + 1
                    color: (index + 1 === new Date().getDate()) ? "white" : "#cccccc"
                    font.pixelSize: 14
                    width: 30
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }

    property bool hovered: false

    Behavior on y {
        NumberAnimation {
            duration: 100
            easing.type: Easing.OutQuad
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
	onEntered: {
		hovered = true
		if (parent.hideTimer) parent.hideTimer.stop()
	}
        onExited: hovered = false
    }

    // No need for showTray/hideTray functions anymore
    // The visibility is controlled by the parent
}
