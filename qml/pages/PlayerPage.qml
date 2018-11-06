import QtQuick 2.2
import Sailfish.Silica 1.0
import Sailfish.Pickers 1.0
import QtMultimedia 5.6

Page {
    id: root

    allowedOrientations: Orientation.Landscape

    QtObject {
        id: internal

        property string selectedMusicFile
        property string title

        onSelectedMusicFileChanged: {
            app.player.source = selectedMusicFile
        }
    }

    Component {
        id: musicPickerPage
        MusicPickerPage {
            onSelectedContentPropertiesChanged: {
                internal.selectedMusicFile = selectedContentProperties.filePath
                internal.title = selectedContentProperties.title
            }
        }
    }

    Item {
        id: cassetteItem
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        height: root.height * 0.8

        Image {
            id: cassetteImage

            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "../images/Cassette.png"

            Text {
                anchors.top: parent.top
                anchors.topMargin: Theme.horizontalPageMargin
                anchors.horizontalCenter: parent.horizontalCenter
                text: internal.title
                font.pixelSize: Theme.fontSizeSmall
            }

            Rectangle {
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.3
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -Theme.horizontalPageMargin
                color: "red"
                width: Theme.iconSizeLarge
                height: Theme.iconSizeLarge
//                radius: 50.0
                RotationAnimation on rotation {
                    loops: Animation.Infinite
                    running: app.playStatus
                    duration: 600
                    from: 360
                    to: 0
                }
            }
            Rectangle {
                anchors.right: parent.right
                anchors.rightMargin: parent.width * 0.3
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -Theme.horizontalPageMargin
                color: "green"
                width: Theme.iconSizeLarge
                height: Theme.iconSizeLarge
//                radius: 50.0
                RotationAnimation on rotation {
                    loops: Animation.Infinite
                    running: app.playStatus
                    duration: 1000
                    from: 360
                    to: 0
                }
            }
        }
    }

    Row {
        anchors.top: cassetteItem.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: Theme.horizontalPageMargin

        clip: true
        spacing: Theme.paddingMedium

        IconButton {
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "image://theme/icon-m-play"

            onClicked: {
                app.player.play()
            }
        }
        IconButton {
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "image://theme/icon-m-previous"
        }
        IconButton {
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "image://theme/icon-m-next"
        }
        IconButton {
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "image://theme/icon-m-pause"
            onClicked: {
                app.player.pause()
            }
        }
        IconButton {
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "image://theme/icon-m-up"

            onClicked: {
                pageStack.push(musicPickerPage)
            }
        }
    }
}
