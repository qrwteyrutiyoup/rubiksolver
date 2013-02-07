import QtQuick 1.1
import RubikCube 1.0

Shear {
    id: container

    property alias color: button.color
    property alias text: buttonText.text
    property alias textSize: buttonText.font.pixelSize
    property alias textFont: buttonText.font.family
    property alias radius: button.radius

    signal clicked()

    Rectangle {
        id: button
        color: "blue"
        anchors.fill: container

        Text {
            id: buttonText
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 20
        }

        MouseArea {
            anchors.fill: parent
            onClicked: container.clicked()
            onEntered: button.scale = 0.95
            onExited: button.scale = 1.0
        }
    }
}
