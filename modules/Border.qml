import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import "../config"
import "."

PanelWindow {
    id: root

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
    WlrLayershell.exclusiveZone: Theme.barHeight

    color: "transparent"

    mask: Region {
        item: null
    }

    property int workspace: 1

    Process {
        id: workspaceProc

        command: [
            "sh",
            "-c",
            "hyprctl activeworkspace -j | python3 -c \"import sys,json; print(json.load(sys.stdin)['id'])\""
        ]

        stdout: SplitParser {
            onRead: function(line) {
                var s = line.trim()

                if (/^\d+$/.test(s))
                    root.workspace = parseInt(s)
            }
        }
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: workspaceProc.running = true
    }

    BorderCanvas {}

    Bar {
        workspace: root.workspace
    }
}
