import QtQuick 1.1
import "rubik/constants.js" as Constants

Rectangle {
    width: 480
    height: 854
    color: "#01102c"

    Rectangle {
        anchors.centerIn: parent

        id: root
        width: 290
        height: 200
        color: "blue"
        radius: 10
        opacity: 0.4
        border.width: 2


        Grid {
            id: grid
            anchors.centerIn: parent
            columns: 3
            spacing: 20

            Repeater {
                model: 6
                Rectangle {
                    width: 64
                    height: 64
                    radius: 32
                    color: "yellow"
                    border.width: 2
                }
            }
        }
    }
}
