import QtQuick 2.12
import QtMultimedia 5.6

Item {
    id: aerial
    property var home: null
    property bool active: false
    property int currentVideo: 0

    // Place your downloaded videos in /var/lib/pearwebos/aerials/ on the TV
    readonly property var videos: [
        "file:///var/lib/pearwebos/aerials/hawaii.mp4",
        "file:///var/lib/pearwebos/aerials/dubai.mp4"
    ]

    visible: active
    anchors.fill: parent
    z: 100

    Video {
        id: videoPlayer
        anchors.fill: parent
        source: aerial.videos[aerial.currentVideo]
        autoPlay: true
        loops: 1
        muted: true
        fillMode: VideoOutput.PreserveAspectCrop
        onStopped: {
            aerial.currentVideo = (aerial.currentVideo + 1) % aerial.videos.length;
            play();
        }
    }

    Keys.onPressed: { aerial.dismiss(); event.accepted = true; }

    function activate() {
        if (videos.length === 0) return;
        active = true;
        videoPlayer.play();
        forceActiveFocus();
    }

    function dismiss() {
        active = false;
        videoPlayer.stop();
        home.takeFocus();
    }

    Timer {
        id: aerialTimer
        interval: 5 * 60 * 1000 // 5 minutes
        running: !home.drawer && !home.panelOpen && uiController.homeShown && !aerial.active
        repeat: false
        onTriggered: aerial.activate()
    }
}
