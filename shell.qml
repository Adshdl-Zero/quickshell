// shell.qml
import QtQuick
import Quickshell
import "modules"

ShellRoot {
    Variants {
        model: Quickshell.screens

        delegate: QtObject {
            required property var modelData
            property var shell: Border { screen: modelData }
        }
    }
}
