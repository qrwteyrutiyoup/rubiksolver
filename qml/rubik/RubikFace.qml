import QtQuick 1.1
import RubikCube 1.0

import "constants.js" as Constants
import "cellarray.js" as Cells

Item {
    id: root
    property int size: 200
    property string faceColor: "white"
    property string outerBorderColor: "#663333"
    property bool outerBorderVisible: false
    property alias hShear: container.horizontalFactor
    property alias vShear: container.verticalFactor
    property variant faceModel

    signal clicked()
    signal stickerClicked(int stickerIndex);

    width: size
    height: size

    Behavior on opacity {
      PropertyAnimation { duration: 150 }
    }

    Shear {
        id: container
        anchors.fill: parent

        Item {
            id: background
            anchors.fill: container

            Grid {
                id: grid
                anchors.fill: parent
                columns: 3
                rows: 3
                spacing: 0

                Component {
                    id: faceDelegate

                    Cell {
                        id: cell
                        editable: root.state === "highlighted";
                        width: root.size / 3
                        height: root.size / 3
                        cellColorIndex: colorIndex
                        onClicked: {
                            stickerClicked(index);
                        }

                        Component.onCompleted: Cells.array.push(cell);
                    }
                }

                Repeater {
                    model: faceModel
                    delegate: faceDelegate
                }
            }

            Rectangle {
                id: mask
                color: "black"
                anchors.fill: parent
                opacity: 0.0
            }

            MouseArea {
                id: faceMouseArea
                anchors.fill: parent
                onClicked: root.clicked()
            }
        }
    }

    states {
        State {
            name: ""
            PropertyChanges { target: faceMouseArea; enabled: true }
            PropertyChanges { target: mask; opacity: 0.0 }
        }

        State {
            name: "highlighted"
            PropertyChanges { target: faceMouseArea; enabled: false }
            PropertyChanges { target: root; z: 10 }
            PropertyChanges { target: mask; opacity: 0.0 }
        }

        State {
            name: "shadowed"
            PropertyChanges { target: faceMouseArea; enabled: false }
            PropertyChanges { target: mask; opacity: 0.8 }
        }
    }

    function reset() {
        for (var i in Cells.array)
            Cells.array[i].state = "default";
    }

    function shadowAll() {
        for (var i in Cells.array)
            Cells.array[i].state = "shadowed";
    }

    function highlightAll() {
        for (var i in Cells.array)
            Cells.array[i].state = "highlighted";
    }

    function plainStupidIndexOf(array, search) {
        for (var i in array) {
            if (array[i] == search)
                return i;
        }
        return -1;
    }

    function highlight(cells) {
        for (var i in Cells.array) {
            if (plainStupidIndexOf(cells, i) == -1)
                Cells.array[i].state = "shadowed";
            else
                Cells.array[i].state = "highlighted";
        }
    }

    function setStickerColor(index, colorIndex) {
        faceModel.setColorIndex(index, colorIndex)
    }
}
