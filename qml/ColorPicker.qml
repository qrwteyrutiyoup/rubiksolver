import QtQuick 1.1

import "rubik/constants.js" as Constants

Item {
    id: root

    Rectangle {
        id: background

        color: "gray"

        border.color: "black"
        border.width: 1

        radius: 5

        opacity: 0.5

        anchors.fill: parent
    }

    signal colorClicked(int clickedColor)

    Grid {
        id: colorGrid

        columns: 3
        rows: 2

        spacing: root.width * 0.1

        anchors.centerIn: parent

        Repeater {
            id: colorRepeater

            model: 6

            Rectangle {
                id: colorCircle

                width: root.width * 0.2
                height: colorCircle.width

                property int colorIndex: (index+1)

                color: Constants.colors[colorIndex]

                radius: colorCircle.width

                MouseArea {
                    anchors.centerIn: parent
                    width: colorCircle.width * 1.25
                    height: colorCircle.height * 1.25
                    onClicked: root.colorClicked(colorIndex)
                }
            }
        }
    }
}
