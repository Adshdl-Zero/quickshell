import QtQuick
import QtQuick.Layouts
import "../config"

Row {
    property int workspace: 1

    spacing: 8

    Repeater {
        model: 5

        delegate: Rectangle {
            property bool active:
                (workspace - 1) % 5 === index

            width: active
                   ? Theme.dotSizeActive
                   : Theme.dotSize

            height: active
                    ? Theme.dotSizeActive
                    : Theme.dotSize

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

                color: parent.active
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
