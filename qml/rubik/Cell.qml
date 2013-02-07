import QtQuick 1.1
import "constants.js" as Constants

Item {
    id: root

    property int cellColorIndex: 1
    property bool editable: false

    signal clicked(variant mouse)

    Rectangle {
        id: rect

        anchors.fill: parent
        smooth: true
        border.width: 4
        radius: 5
        border.color: "black"
        color: Constants.colors[cellColorIndex]
        gradient: Gradient {
            GradientStop {
                position: 0.6
                color: rect.color
            }
        }
    }

    MouseArea {
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        enabled: root.editable
        anchors.fill: parent
        onClicked: {
            root.clicked(mouse)
        }
    }

    states: [
        State {
            name: "default"
            PropertyChanges { target: rect; opacity: 1.0; }
        },
        State {
            name: "highlighted"
        },
        State {
            name: "shadowed"
        }
    ]

    transitions: [
        Transition {
            to: "highlighted"

            SequentialAnimation {
                NumberAnimation {
                    target: rect
                    property: "opacity"
                    to: 0.4
                    duration: 300
                }
                NumberAnimation {
                    target: rect
                    property: "opacity"
                    to: 1.0
                    duration: 300
                }
                PropertyAction {
                    target: root
                    property: "state"
                    value: ""
                }
            }
        },
        Transition {
            to: "shadowed"

            SequentialAnimation {
                NumberAnimation {
                    target: rect
                    property: "opacity"
                    to: 0.4
                    duration: 300
                }
                PropertyAction {
                    target: root
                    property: "state"
                    value: ""
                }
            }
        }
    ]
}
