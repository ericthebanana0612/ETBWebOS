import QtQuick 2.12
import QtGraphicalEffects 1.12

Item {
    id: controlCenter
    property var home: null
    property bool shown: false

    visible: shown
    anchors.fill: parent
    z: 90

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0, 0, 0, 0.4)
        opacity: shown ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 250 } }
        MouseArea { anchors.fill: parent; onClicked: controlCenter.hide() }
    }

    Rectangle {
        id: panel
        width: home.r(600); height: home.r(400)
        anchors.horizontalCenter: parent.horizontalCenter
        y: shown ? home.r(60) : -height
        radius: home.r(24)
        color: Qt.rgba(1, 1, 1, 0.12)
        border.color: Qt.rgba(1, 1, 1, 0.15)
        border.width: Math.max(1, home.r(1))
        
        layer.enabled: true
        layer.effect: FastBlur { radius: 32; transparentBorder: true }
        Behavior on y { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }

        Column {
            anchors.centerIn: parent; spacing: home.r(32)
            Text {
                text: "Control Center"
                color: "#ffffff"
                font.pixelSize: home.r(32)
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Row {
                spacing: home.r(40)
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle { width: home.r(100); height: home.r(100); radius: home.r(20); color: Qt.rgba(1, 1, 1, 0.15) 
                    Text { anchors.centerIn: parent; text: "Sleep"; color: "#fff"; font.pixelSize: home.r(18) } }
                Rectangle { width: home.r(100); height: home.r(100); radius: home.r(20); color: Qt.rgba(1, 1, 1, 0.15) 
                    Text { anchors.centerIn: parent; text: "Audio"; color: "#fff"; font.pixelSize: home.r(18) } }
                Rectangle { width: home.r(100); height: home.r(100); radius: home.r(20); color: Qt.rgba(1, 1, 1, 0.15) 
                    Text { anchors.centerIn: parent; text: "Profile"; color: "#fff"; font.pixelSize: home.r(18) } }
            }
        }
    }

    function show() { shown = true; forceActiveFocus(); }
    function hide() { shown = false; home.takeFocus(); }
    Keys.onPressed: { if (event.key === Qt.Key_Back || event.key === Qt.Key_Escape) { hide(); event.accepted = true; } }
}
