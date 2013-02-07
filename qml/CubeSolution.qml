import QtQuick 1.1
import "cubesolution.js" as Solution
import "platform.js" as Platform

Item {
    id: root

    signal back()

    function solve() {
        Solution.moveIndex = 0;
        return Solution.solve();
    }

    SolutionArrow {
        id: arrowHorizontalLeft

        scale: 0
        source: "qrc:///img/arrow_horizontal_left.png"
        width: Platform.arrowDimension
        height: arrowHorizontalLeft.width
        transformOrigin: Item.Right
    }

    SolutionArrow {
        id: arrowHorizontalRight

        scale: 0
        source: "qrc:///img/arrow_horizontal_right.png"
        width: arrowHorizontalLeft.width
        height: arrowHorizontalLeft.height
        transformOrigin: Item.Left
    }

    SolutionArrow {
        id: arrowVerticalLeftUp

        scale: 0
        source: "qrc:///img/arrow_vertical_left_up.png"
        width: arrowHorizontalLeft.width
        height: arrowHorizontalLeft.height
        transformOrigin: Item.Bottom
    }

    SolutionArrow {
        id: arrowVerticalLeftDown

        scale: 0
        source: "qrc:///img/arrow_vertical_left_down.png"
        width: arrowHorizontalLeft.width
        height: arrowHorizontalLeft.height
        transformOrigin: Item.TopRight
    }

    SolutionArrow {
        id: arrowVerticalRightUp

        scale: 0
        source: "qrc:///img/arrow_vertical_right_up.png"
        width: arrowHorizontalLeft.width
        height: arrowHorizontalLeft.height
        transformOrigin: Item.Bottom
    }

    SolutionArrow {
        id: arrowVerticalRightDown

        scale: 0
        source: "qrc:///img/arrow_vertical_right_down.png"
        width: arrowHorizontalLeft.width
        height: arrowHorizontalLeft.height
        transformOrigin: Item.TopLeft
    }



    Text {
        font.pixelSize: Platform.scaleFactor * 32
        font.bold: true
        color: "white"
        text: "Hint"
        x: Platform.solutionTextX
        y: Platform.solutionHintY
    }

    Text {
        id: moveDescription
        font.pixelSize: Platform.scaleFactor * 22
        color: "white"
        wrapMode: Text.WordWrap
        width: 200
        x: Platform.solutionTextX
        y: Platform.solutionMoveDescriptionY
    }


    Text {
        font.pixelSize: Platform.scaleFactor * 32
        font.bold: true
        color: "white"
        text: "Moves"
        x: Platform.solutionTextX
        y: Platform.solutionMovesY
    }

    Text {
        id: remainingMoves
        font.pixelSize: Platform.scaleFactor * 22
        color: "white"
        x: Platform.solutionTextX
        y: Platform.solutionRemaninngMovesY
    }

    Button {
        id: next
        x: (header.width + previous.width) / 2 + Platform.nextButtonOffsetX
        y:  root.height - footer.height - previous.height / 2 + Platform.nextButtonOffsetY
        width: cube.dimension * 2/3
        height: cube.dimension / 3
        text: "next"
        textFont: "Bebas Neue"
        textSize: 42
        horizontalFactor: 0.5
        color: "#ca2454"
        onClicked: Solution.nextMove(cube)
        scale: Platform.scaleFactor


        Rotation {
            id: rotNext
            angle: -34
            origin.x: next.width / 2
            origin.y: next.height / 2
        }

        Scale {
            id: scaNext
            yScale: 0.86062
            origin.x: next.width / 2
            origin.y: next.height / 2
        }

        transform: [rotNext, scaNext]
    }

    Button {
        id: previous
        x: (header.width - previous.width) / 2 + Platform.previousButtonOffsetX
        y:  root.height - footer.height + Platform.previousButtonOffsetY
        width: cube.dimension * 2/3
        height: cube.dimension / 3
        text: "prev"
        textFont: "Bebas Neue"
        textSize: 42
        horizontalFactor: 0.5
        color: "#2485c9"
        onClicked: Solution.previousMove(cube)
        scale: Platform.scaleFactor


        Rotation {
            id: rotPrevious
            angle: -34
            origin.x: next.width / 2
            origin.y: next.height / 2
        }

        Scale {
            id: scaPrevious
            yScale: 0.86062
            origin.x: next.width / 2
            origin.y: next.height / 2
        }

        transform: [rotPrevious, scaPrevious]
    }

    Button {
        id: backButton
        x: (header.width + backButton.width) / 2 + Platform.backButtonOffsetX
        y:  header.height  + Platform.backButtonOffsetY
        width: cube.dimension * 2/3
        height: cube.dimension / 3
        color: "#ff8500"
        text: "back"
        textFont: "Bebas Neue"
        textSize: 42
        horizontalFactor: -0.5

        onClicked: Solution.returnFromSolution();
        scale: Platform.scaleFactor

        Scale {
            id: scaBack
            yScale: 0.86062
        }

        Rotation {
            id: rotBack
            angle: -30
        }

        transform: [scaBack, rotBack]
    }
}
