import QtQuick 1.1
import "cubesolution.js" as Solution

Image {
    id: root

    scale: 0

    states {
        State {
            name: "visible"
        }

        State {
            name: "hidden"

            PropertyChanges { target: root; scale: 0 }
        }
    }

    transitions: Transition {
        to: "visible"

        SequentialAnimation {
            PropertyAction {
                target: root
                property: "scale"
                value: 0.0
            }
            PauseAnimation {
                duration: 450
            }
            NumberAnimation {
                target: root
                property: "scale"
                duration: 300
                to: 1.0
            }
        }
    }
}
