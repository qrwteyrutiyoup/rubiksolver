import QtQuick 1.1
import "rubik"
import "rubik/constants.js" as Constants
import "cubesetup.js" as Setup
import "platform.js" as Platform

Rectangle {
    id: root
    color: "#01102c"

    MessageDialog {
        id: cubeMispaintedDialog

        z: 100
        message: qsTr("<p align='center'>The cube is mispainted. Please check if the sticker colors are entered correctly.</p>")
        titleText: qsTr("<b>Error<\b>")

        onMessageClose: {
            cube.blur = 0.0;
        }

    }

    MessageDialog {
        id: cubeSolvedDialog

        z: 100
        message: qsTr("<p align='center'>The cube is already solved!</p>")
        titleText: qsTr("<b>Warning<\b>")

        onMessageClose: {
            cube.blur = 0.0;
        }
    }

    Rubik {
        id: cube
    }

    Rectangle {
        id: header
        anchors.top: root.top
        height: Platform.scaleFactor  * cube.dimension / 2
        width: root.width
        color: "transparent"
    }

    Rectangle {
        id: footer
        anchors.bottom: root.bottom
        height: Platform.scaleFactor * cube.dimension / 2
        width: root.width
        color: "transparent"
    }

    CubeSetup {
        id: cubeSetup
        anchors.fill: parent

        onSolve: {
            switch(cubeSolution.solve()) {
             case 0: {
                 cube.blur = 5.0
                 cubeSolvedDialog.open();
                 break;
             }
             case 1:
                 root.state = "cubeSolution"
                 break;
             case -1: {
                 cube.blur = 5.0;
                 cubeMispaintedDialog.open();
                 break;
             }
            }
        }

        onReset: cubeSetup.resetCube()
        onScramble: cubeSetup.scrambleCube()
    }

    CubeSolution {
        id: cubeSolution
        anchors.fill: parent

        onBack: root.state = "cubeSetup"
    }

    transitions {
        Transition {
            to: "cubeSolution"
            PropertyAction { target: cubeSolution; property: "visible"; value: "true" }
            PropertyAction { target: cube; property: "sixFaces"; value: "false" }
            PropertyAction { target: cubeSetup; property: "visible"; value: "false" }
            PropertyAction { target: cubeSetup; property: "configurable"; value: "false" }
        }

        Transition {
            to: "cubeSetup"
            PropertyAction { target: cubeSetup; property: "visible"; value: "true" }
            PropertyAction { target: cubeSetup; property: "state"; value: "" }
            PropertyAction { target: cubeSetup; property: "configurable"; value: "true" }
            PropertyAction { target: cube; property: "sixFaces"; value: "true" }
            PropertyAction { target: cubeSolution; property: "visible"; value: "false" }
        }

    }

    Component.onCompleted: root.state = "cubeSetup"
}

