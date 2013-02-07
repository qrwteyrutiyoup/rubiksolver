import QtQuick 1.1
import "rubik"
import "rubik/constants.js" as Constants
import "cubesetup.js" as Setup
import "platform.js" as Platform

Item {
    id: root

    state: "showCube"

    property variant currentFace
    property int margin: root.width / 45
    property bool configurable: true

    signal solve()
    signal reset()
    signal scramble()

    onCurrentFaceChanged: {
        //TODO: ... do something better than this
        currentFace.stickerClicked.disconnect()
        currentFace.stickerClicked.connect(activateColorPicker)
    }

    ColorPicker {
        id: colorPicker

        property int currentIndex

        width: root.width * 0.55
        height: root.height * 0.2

        opacity: 0.0

        anchors.centerIn: parent

        Behavior on opacity {
            NumberAnimation {
                duration: 300
            }
        }

        onColorClicked: {
            currentFace.setStickerColor(currentIndex, clickedColor);
            colorPicker.opacity = 0.0
        }
    }

    function scrambleCube() {
        Setup.scramble()
    }

    function resetCube() {
        Setup.reset()
    }

    Rectangle {
        id: miniCubeBg
        x: header.x
        y: header.y
        anchors.margins: 20
        width: 100
        height: 140
        radius: 20
        smooth: true
        border.color: "black"
        border.width: 3
        opacity: miniCube.opacity / 2
        scale: Platform.scaleFactor
    }

    Rubik {
        id: miniCube
        anchors.centerIn: miniCubeBg
        scale: 0.2 * Platform.scaleFactor
        background.visible: false
    }

    Button {
        id: solveButton
        x: (footer.width + solveButton.width) / 2 + Platform.solveButtonOffsetX
        y: root.height - footer.height + Platform.solveButtonOffsetY
        width: cube.dimension * 2/3
        height: cube.dimension / 3
        text: "solve"
        textFont: "Bebas Neue"
        textSize: 42
        horizontalFactor: 0.5
        color: "#ca2454"
        onClicked: root.solve();
        scale: Platform.scaleFactor


        Rotation {
            id: rotSolve
            angle: -34
            origin.x: solveButton.width / 2
            origin.y: solveButton.height / 2
        }

        Scale {
            id: scaSolve
            yScale: 0.86062
            origin.x: solveButton.width / 2
            origin.y: solveButton.height / 2
        }

        transform: [rotSolve, scaSolve]
    }

     Button {
        id: resetButton
        width: cube.dimension * 2/3
        height: cube.dimension / 3
        x: (header.width + resetButton.width) / 2 + Platform.resetButtonOffsetX
        y:  header.height + Platform.resetButtonOffsetY
        text: "reset"
        textFont: "Bebas Neue"
        textSize: 42
        horizontalFactor: -0.5
        color: "#ff8500"
        onClicked: root.reset();
        scale: Platform.scaleFactor

        Scale {
            id: scaReset
            yScale: 0.86062
        }

        Rotation {
            id: rotReset
            angle: -30
        }

        transform: [scaReset, rotReset]
    }


     Button {
        id: scrambleButton

        width: cube.dimension
        height: cube.dimension / 3
        x: (header.width - scrambleButton.width) / 2 + Platform.scrambleButtonOffsetX
        y:  header.height  + Platform.scrambleButtonOffsetY
        text: "scramble"
        textFont: "Bebas Neue"
        textSize: 42
        horizontalFactor: 0.5
        color: "#ca2454"
        onClicked: root.scramble();
        scale: Platform.scaleFactor

        Rotation {
            id: rotScramble
            angle: 30
            origin.x: scrambleButton.width / 2
            origin.y: scrambleButton.height / 2
        }

        Scale {
            id: scaScramble
            yScale: 0.86062
            origin.x: scrambleButton.width / 2
            origin.y: scrambleButton.height / 2
        }

        Rotation {
            id: rot2Scramble
            angle: -57
        }

        transform: [rotScramble, scaScramble, rot2Scramble]
    }

    Item {
        id: background
        width: root.width
        height: root.height - 200
        anchors.bottom: root.bottom

        Button {
            id: doneButton
            x: (footer.width + solveButton.width) / 2 + Platform.doneButtonOffsetX
            y: background.height - footer.height + Platform.doneButtonOffsetY
            width: cube.dimension * 2/3
            height: cube.dimension / 3
            text: "done"
            textFont: "Bebas Neue"
            textSize: 42
            horizontalFactor: 0.5
            color: "#ca2454"
            onClicked: root.state = "";
            scale: Platform.scaleFactor

            Rotation {
                id: rotDone
                angle: -34
                origin.x: solveButton.width / 2
                origin.y: solveButton.height / 2
            }

            Scale {
                id: scaDone
                yScale: 0.86062
                origin.x: solveButton.width / 2
                origin.y: solveButton.height / 2
            }

            transform: [rotDone, scaDone]
        }

    }

    Connections {
        target: cube
        onFaceClicked: {
            if (configurable) {
                currentFace = face;
                root.state = face.objectName + "Setup";
            }
        }
    }

    states {
        State {
            name: ""
            StateChangeScript { script: Setup.restoreFaces() }
            PropertyChanges { target: miniCube; opacity: 0.0 }
            PropertyChanges { target: cube; x: (root.width - cube.width) / 2; y: (root.height - cube.height) / 2; scale: Platform.scaleFactor * 1 }
            PropertyChanges { target: background; opacity: 0.0 }
            PropertyChanges { target: solveButton; opacity: 1.0 }
            PropertyChanges { target: scrambleButton; opacity: 1.0 }
            PropertyChanges { target: resetButton; opacity: 1.0 }
            PropertyChanges { target: colorPicker; opacity: 0.0 }
        }

        State {
            name: "frontFaceSetup"
            PropertyChanges { target: cube; x: Platform.frontFaceCubeSetupX; y: Platform.frontFaceCubeSetupY; scale: Platform.scaleFactor * 1.8 }
            PropertyChanges { target: miniCube; opacity: 1.0 }
            PropertyChanges { target: background; opacity: 1 }
            PropertyChanges { target: solveButton; opacity: 0.0 }
            PropertyChanges { target: scrambleButton; opacity: 0.0 }
            PropertyChanges { target: resetButton; opacity: 0.0 }
            StateChangeScript { script: Setup.shadowOtherFaces(root.currentFace) }
        }

        State {
            name: "backFaceSetup"
            PropertyChanges { target: cube; x: Platform.backFaceCubeSetupX; y: Platform.backFaceCubeSetupY; scale: Platform.scaleFactor * 1.8 }
            PropertyChanges { target: miniCube; opacity: 1.0 }
            PropertyChanges { target: background; opacity: 1 }
            PropertyChanges { target: solveButton; opacity: 0.0 }
            PropertyChanges { target: scrambleButton; opacity: 0.0 }
            PropertyChanges { target: resetButton; opacity: 0.0 }
            StateChangeScript { script: Setup.shadowOtherFaces(root.currentFace) }
        }

        State {
            name: "leftFaceSetup"
            PropertyChanges { target: cube; x: Platform.leftFaceCubeSetupX; y: Platform.leftFaceCubeSetupY; scale: Platform.scaleFactor * 1.8 }
            PropertyChanges { target: miniCube; opacity: 1.0 }
            PropertyChanges { target: background; opacity: 1 }
            PropertyChanges { target: solveButton; opacity: 0.0 }
            PropertyChanges { target: scrambleButton; opacity: 0.0 }
            PropertyChanges { target: resetButton; opacity: 0.0 }
            StateChangeScript { script: Setup.shadowOtherFaces(root.currentFace) }
        }

        State {
            name: "rightFaceSetup"
            PropertyChanges { target: cube; x: Platform.rightFaceCubeSetupX; y: Platform.rightFaceCubeSetupY; scale: Platform.scaleFactor * 1.8 }
            PropertyChanges { target: miniCube; opacity: 1.0 }
            PropertyChanges { target: background; opacity: 1 }
            PropertyChanges { target: solveButton; opacity: 0.0 }
            PropertyChanges { target: scrambleButton; opacity: 0.0 }
            PropertyChanges { target: resetButton; opacity: 0.0 }
            StateChangeScript { script: Setup.shadowOtherFaces(root.currentFace) }
        }

        State {
            name: "topFaceSetup"
            PropertyChanges { target: cube; x: Platform.topFaceCubeSetupX; y: Platform.topFaceCubeSetupY; scale: Platform.scaleFactor * 1.5 }
            PropertyChanges { target: miniCube; opacity: 1.0 }
            PropertyChanges { target: background; opacity: 1 }
            PropertyChanges { target: solveButton; opacity: 0.0 }
            PropertyChanges { target: scrambleButton; opacity: 0.0 }
            PropertyChanges { target: resetButton; opacity: 0.0 }
            StateChangeScript { script: Setup.shadowOtherFaces(root.currentFace) }
        }

        State {
            name: "bottomFaceSetup"
            PropertyChanges { target: cube; x: Platform.bottomFaceCubeSetupX; y: Platform.bottomFaceCubeSetupY; scale: Platform.scaleFactor * 1.5 }
            PropertyChanges { target: miniCube; opacity: 1.0 }
            PropertyChanges { target: background; opacity: 1 }
            PropertyChanges { target: solveButton; opacity: 0.0 }
            PropertyChanges { target: scrambleButton; opacity: 0.0 }
            PropertyChanges { target: resetButton; opacity: 0.0 }
            StateChangeScript { script: Setup.shadowOtherFaces(root.currentFace) }
        }
    }

    transitions {
        Transition {
            NumberAnimation {
                target: cube
                properties: "x, y"
                duration: 200
                easing.type: Easing.InQuad
            }

            NumberAnimation {
                target: cube
                properties: "scale"
                duration: 200
                easing.type: Easing.InQuad
            }

            NumberAnimation {
                target: miniCube
                property: "opacity"
                duration: 200
                easing.type: Easing.InQuad
            }

            NumberAnimation {
                targets: [solveButton, scrambleButton, resetButton]
                property: "opacity"
                duration: 200
                easing.type: Easing.InQuad
            }
        }
    }

    function activateColorPicker(stickerIndex) {
        colorPicker.currentIndex = stickerIndex
        colorPicker.opacity = 1.0
    }
}
