import QtQuick 1.1
import Effects 1.0

Item {
    id: root

    property bool sixFaces: true
    property string cubeColor: "black"
    property real dimension: bgCube.sourceSize.width * 0.45
    property alias background: bgCube
    property alias blur: rubikBlur.blurRadius

    property variant topFaceModel: rubikTopFaceModel
    property variant rightFaceModel: rubikRightFaceModel
    property variant frontFaceModel: rubikFrontFaceModel
    property variant backFaceModel: rubikBackFaceModel
    property variant leftFaceModel: rubikLeftFaceModel
    property variant bottomFaceModel: rubikBottomFaceModel

    property variant faces: {
        "top": topFace,
        "left": leftFace,
        "front": frontFace,
        "right": rightFace,
        "back": backFace,
        "bottom": bottomFace
    }
    signal faceClicked(variant face);

    effect: Blur {
        id: rubikBlur
        blurRadius: 0.0
    }

    Image {
        id: bgCube
        smooth: true
        source: ":/img/bg-cube.png"
        anchors.centerIn: parent
        z: 1
    }

    Item {
        id: frontLayer
        anchors.fill: bgCube
        z: 2

        RubikFace {
            id: topFace
            objectName: "topFace"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            size: dimension

            Rotation {
                id: rot1T
                angle: 30
                origin.x: topFace.width / 2
                origin.y: topFace.height / 2
            }

            Scale {
                id: sca1T
                yScale: 0.86062
                origin.x: topFace.width / 2
                origin.y: topFace.height / 2
            }

            Translate {
                id: tra1T
                y: 80
                x: 35
            }

            hShear: -0.5
            transform: [sca1T, rot1T, tra1T]

            faceColor: cubeColor
            faceModel: topFaceModel
            onClicked: root.faceClicked(topFace);
        }

        RubikFace {
            id: frontFace
            objectName: "frontFace"
            anchors.top: topFace.bottom
            anchors.right: topFace.horizontalCenter
            size: dimension

            Scale {
                id: sca1F
                yScale: 0.86062
            }

            Rotation {
                id: rot1F
                angle: 30
            }

            Translate {
                id: tra1F
                x: 22
                y: -32
            }

            transform: [sca1F, rot1F, tra1F]
            hShear: 0.5

            faceColor: cubeColor
            faceModel: frontFaceModel
            onClicked: root.faceClicked(frontFace);
        }

        RubikFace {
            id: rightFace
            objectName: "rightFace"
            anchors.top: topFace.bottom
            anchors.left: topFace.horizontalCenter
            size: dimension

            Scale {
                id: sca1RF
                yScale: 0.86062
            }

            Rotation {
                id: rot1RF
                angle: -30
            }

            Translate {
                id: tra1RF
                y: 56
                x: -3
            }

            transform: [sca1RF, rot1RF, tra1RF]
            hShear: -0.5

            faceColor: cubeColor
            faceModel: rightFaceModel
            onClicked: root.faceClicked(rightFace);
        }
    }

    RubikFace {
        id: bottomFace
        objectName: "bottomFace"
        anchors.horizontalCenter: frontLayer.horizontalCenter
        anchors.verticalCenter: frontLayer.bottom
        visible: sixFaces
        size: dimension
        z: -4

        Rotation {
            id: rot1B
            angle: -30
            origin.x: topFace.width / 2
            origin.y: topFace.height / 2
        }

        Scale {
            id: sca1B
            yScale: 0.86062
            origin.x: topFace.width / 2
            origin.y: topFace.height / 2
        }

        Translate {
            id: tra1B
            x: -40
            y: 20
        }

        hShear: 0.5
        transform: [sca1B, rot1B, tra1B]

        faceColor: cubeColor
        faceModel: bottomFaceModel
        onClicked: root.faceClicked(bottomFace);
    }

    RubikFace {
        id: backFace
        objectName: "backFace"
        size: dimension
        visible: sixFaces

        Scale {
            id: sca1RB
            yScale: 0.86062
        }

        Rotation {
            id: rot1RB
            angle: 30
        }

        Translate {
            id: tra1RB
            x: 70
            y: -280
        }

        transform: [sca1RB, rot1RB, tra1RB]
        hShear: 0.5

        faceColor: cubeColor
        faceModel: backFaceModel
        onClicked: root.faceClicked(backFace);
    }

    RubikFace {
        id: leftFace
        objectName: "leftFace"
        size: dimension
        visible: sixFaces

        Scale {
            id: sca1LF
            yScale: 0.86062
        }

        Rotation {
            id: rot1LF
            angle: -30
        }

        Translate {
            id: tra1LF
            y: -190
            x: -230
        }

        transform: [sca1LF, rot1LF, tra1LF]
        hShear: -0.5

        faceColor: cubeColor
        faceModel: leftFaceModel
        onClicked: root.faceClicked(leftFace);
    }
}
