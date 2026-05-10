import QtQuick
import QtQuick.Layouts
import "../config"
import "."

Item {
    property int workspace: 1

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

    height: Theme.barHeight

    DateWidget {
        anchors {
            left: parent.left
            leftMargin: 16
            verticalCenter: parent.verticalCenter
        }
    }

    WorkspaceDots {
        anchors.centerIn: parent
        workspace: parent.workspace
    }

    BatteryWidget {
        anchors {
            right: parent.right
            rightMargin: 16
            verticalCenter: parent.verticalCenter
        }
    }
}
