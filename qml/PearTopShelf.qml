import QtQuick 2.12

Item {
    id: topShelf
    property var home: null
    property var focusedApp: null
    property var shelfItems: []

    onFocusedAppChanged: {
        if (!focusedApp || !focusedApp.id) {
            shelfItems = [];
            return;
        }
        webOS.service.request("luna://com.webos.service.applicationmanager", {
            method: "getAppInfo",
            parameters: { id: focusedApp.id },
            onSuccess: function (res) {
                topShelf.fetchContentForApp(res.appId);
            },
            onFailure: function (err) {
                shelfItems = [];
            }
        });
    }

    function fetchContentForApp(appId) {
        var mockContent = {
            "netflix": [
                { title: "Stranger Things", image: "https://image.tmdb.org/t/p/w500/49WJfeN0moxb9IPfGn8AIqMGskD.jpg" },
                { title: "The Crown", image: "https://image.tmdb.org/t/p/w500/1M876KPjulVwppEpldhdc8V4o68.jpg" }
            ],
            "com.webos.app.disneyplus": [
                { title: "The Mandalorian", image: "https://image.tmdb.org/t/p/w500/sWgBv7LV2PRoQgkxwlibdGXKz1S.jpg" }
            ],
            "com.webos.app.primevideo": [
                { title: "The Boys", image: "https://image.tmdb.org/t/p/w500/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg" }
            ]
        };
        shelfItems = mockContent[appId] || [];
    }

    visible: shelfItems.length > 0 && !home.drawer && !home.quiet
    height: home.r(260)
    y: home.r(380)

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: home.r(24)
        Repeater {
            model: topShelf.shelfItems
            delegate: Item {
                width: home.r(280); height: home.r(180)
                Rectangle {
                    anchors.fill: parent; radius: home.r(16); color: "#1a1a1a"
                    Image {
                        anchors.fill: parent
                        source: modelData.image
                        fillMode: Image.PreserveAspectCrop
                        asynchronous: true
                    }
                }
                Text {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: home.r(8)
                    text: modelData.title
                    color: "#ffffff"
                    font.pixelSize: home.r(20)
                    style: Text.Outline; styleColor: "#000000"
                }
            }
        }
    }
}
