import QtQuick
import "../config"

Item {
    width: 100

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
}
