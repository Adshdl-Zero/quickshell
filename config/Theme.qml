// config/Theme.qml
pragma Singleton
import QtQuick

QtObject {
    // Border
    readonly property int   borderThickness: 7
    readonly property color borderColor:     Qt.rgba(0.2, 0.2, 0.2, 0.20)
    readonly property color borderGlow:      Qt.rgba(0.2, 0.2, 0.2, 0.20)
    readonly property int   borderRadius:    20

    // Bar
    readonly property int   barHeight:       26
    readonly property color barText:         Qt.rgba(1, 1, 1, 0.90)
    readonly property color barTextMuted:    Qt.rgba(1, 1, 1, 0.50)


    readonly property int  dotSize:        10   // inactive dot size
    readonly property int  dotSizeActive:  12   // active dot size
    readonly property color dotColor:      Qt.rgba(1, 1, 1, 0.15)  // inactive
    readonly property color dotColorActive: Qt.rgba(1, 1, 1, 0.35) // active

    // Shared
    readonly property string fontFamily: "JetBrains Mono"
    readonly property int    cornerRadius: 14
}
