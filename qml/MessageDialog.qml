import QtQuick 1.1
import Effects 1.0
import "platform.js" as Platform

Item {
    id: messageWindow
    property alias message: message.text
    property alias titleText: title.text

    signal messageClose();

    anchors.fill: parent

    visible: background.opacity !== 0.0

    Rectangle {
        id: background

        opacity: 0.0
        anchors.fill: parent
        color: "black"

        Behavior on opacity {
            PropertyAnimation {

            }
        }
    }

    function open() {
        messageItem.visible = true;
        background.opacity = 0.6;
    }

    function close() {
        messageItem.visible = false;
        background.opacity = 0.0;
    }

    Item {
        id: messageItem
        anchors.centerIn: parent
        width: parent.width - 80

        visible: false

        Text {
            id: title

            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            font.bold: true
            font.pixelSize: 32
            scale: Platform.scaleFactor
        }

        Text {
            id: message

            anchors.top: title.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignCenter
            width: parent.width
            wrapMode: Text.Wrap
            color: "white"
            font.pixelSize: 22
            scale: Platform.scaleFactor
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            messageWindow.close()
            messageWindow.messageClose();
        }

    }

}

