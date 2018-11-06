import QtQuick 2.2
import Sailfish.Silica 1.0
import QtMultimedia 5.6
import "pages"

ApplicationWindow
{
    id: app

    property alias player: audio

    property bool playStatus: false

    initialPage: Component { PlayerPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations

    Audio {
        id: audio

        onPlaying: {
            app.playStatus = true
        }

        onPaused: {
            app.playStatus = false
        }

        onStopped: {
            app.playStatus = false
        }
    }
}
