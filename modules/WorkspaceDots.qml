import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "../config"

Row {
    property int workspace: 1

    spacing: 8

    function switchWorkspace(clickedIndex) {
        var activeIndex = (workspace - 1) % 5
        var target

        if (clickedIndex < activeIndex) {
            // Go to absolute workspace for that dot in current cycle
            var cycleStart = workspace - activeIndex
            target = cycleStart + clickedIndex
        } else if (clickedIndex > activeIndex) {
            // Go to relative workspace
            target = workspace + (clickedIndex - activeIndex)
        } else {
            // Active dot, do nothing
            return
        }

        switchProc.command = ["hyprctl", "dispatch", "workspace", target.toString()]
        switchProc.running = true
    }

    Process {
        id: switchProc
        command: []
    }

    Repeater {
        model: 5

        delegate: MouseArea {
            property bool active:
                (workspace - 1) % 5 === index

            width: active
                   ? Theme.dotSizeActive
                   : Theme.dotSize

            height: active
                    ? Theme.dotSizeActive
                    : Theme.dotSize

                onClicked: switchWorkspace(index)

            Rectangle {
                anchors.fill: parent
                radius: width / 2
                color: "transparent"
                border.color: active
                              ? Theme.dotColorActive
                              : Theme.dotColor
                border.width: active ? 2 : 1.5

                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width - 4
                    height: parent.height - 4
                    radius: width / 2
                    color: active
                           ? Theme.dotColorActive
                           : Theme.dotColor
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }

                Behavior on width {
                    NumberAnimation { duration: 150 }
                }

                Behavior on height {
                    NumberAnimation { duration: 150 }
                }

                Behavior on border.color {
                    ColorAnimation { duration: 150 }
                }
            }
        }
    }
}

