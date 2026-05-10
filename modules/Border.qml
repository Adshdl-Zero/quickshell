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
    WlrLayershell.exclusiveZone: fullscreenActive ? 0 : Theme.barHeight

    color: "transparent"

    visible: !fullscreenActive

    mask: Region {
        item: bar
    }

    property bool fullscreenActive: false
    property int workspace: 1

    Process {
        id: fullscreenProc
        command: [
            "sh",
            "-c",
            "hyprctl activewindow -j 2>/dev/null | python3 -c 'import sys,json; s=sys.stdin.read().strip(); print(\"false\" if not s else (\"true\" if (lambda d: d.get(\"fullscreenMode\",0) or d.get(\"fullscreen\", False) or d.get(\"state\",\"\") == \"fullscreen\")(json.loads(s)) else \"false\"))'"
        ]

        stdout: SplitParser {
            onRead: function(line) {
                fullscreenActive = line.trim() === "true"
            }
        }
    }

    Timer {
        interval: 200
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: fullscreenProc.running = true
    }

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
        id: bar
        workspace: root.workspace
    }
}

