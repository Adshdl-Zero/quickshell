import QtQuick
import Quickshell
import Quickshell.Io
import "../config"

Item {
    property int battery: 100
    property bool charging: false

    width: 100

    // battery %
    Process {
        id: batteryProc

        command: [
            "cat",
            "/sys/class/power_supply/BAT0/capacity"
        ]

        stdout: SplitParser {
            onRead: function(line) {
                var s = line.trim()

                if (/^\d{1,3}$/.test(s)) {
                    var n = parseInt(s)

                    if (n >= 0 && n <= 100)
                        battery = n
                }
            }
        }
    }

    // charging state
    Process {
        id: chargingProc

        command: [
            "cat",
            "/sys/class/power_supply/BAT0/status"
        ]

        stdout: SplitParser {
            onRead: function(line) {
                var s = line.trim()

                charging = (s === "Charging")
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            batteryProc.running = true
            chargingProc.running = true
        }
    }

    Canvas {
        id: boltCanvas

        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: 1
        }

        width: 10
        height: 16

        opacity: charging ? 1 : 0
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }

        onPaint: {
            var ctx = getContext("2d")

            ctx.clearRect(0, 0, width, height)

            ctx.fillStyle = "#ffffff"

            ctx.beginPath()

            ctx.moveTo(7, 0)
            ctx.lineTo(2, 8)
            ctx.lineTo(5, 8)
            ctx.lineTo(3, 16)
            ctx.lineTo(9, 6)
            ctx.lineTo(6, 6)
            ctx.lineTo(7, 0)

            ctx.closePath()
            ctx.fill()
        }
    }

    Text {
        anchors {
            right: charging
                   ? boltCanvas.left
                   : parent.right

            rightMargin: charging ? 4 : 0

            verticalCenter: parent.verticalCenter
        }

        text: battery + "%"

        color: battery <= 20
               ? "#ff6b6b"
               : Theme.barText

        font {
            family: Theme.fontFamily
            pixelSize: 13
            weight: Font.Medium
        }

        Behavior on anchors.rightMargin {
            NumberAnimation { duration: 200 }
        }
    }
}
