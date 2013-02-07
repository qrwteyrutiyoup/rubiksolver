var scaleFactor = 0.75

var width = 360
var height = 640

// buttons setup
var scrambleButtonOffsetX = -15
var scrambleButtonOffsetY = 55

var resetButtonOffsetX = -20
var resetButtonOffsetY = -10

var solveButtonOffsetX = -36
var solveButtonOffsetY = -20

var doneButtonOffsetX = solveButtonOffsetX
var doneButtonOffsetY = solveButtonOffsetY


// buttons solution
var backButtonOffsetX = 0
var backButtonOffsetY = -5

var previousButtonOffsetX = -40
var previousButtonOffsetY = -10

var nextButtonOffsetX = -38
var nextButtonOffsetY =0


// main cube faces
var frontFaceCubeSetupX = 290
var frontFaceCubeSetupY = 270

var leftFaceCubeSetupX = 380
var leftFaceCubeSetupY = 530

var rightFaceCubeSetupX = 80
var rightFaceCubeSetupY = 280

var backFaceCubeSetupX = -20
var backFaceCubeSetupY = 525

var topFaceCubeSetupX = 180
var topFaceCubeSetupY = 430

var bottomFaceCubeSetupX = 180
var bottomFaceCubeSetupY = 80


// texts solution
var solutionTextX = 30
var solutionMovesY = 55
var solutionRemaninngMovesY = 85
var solutionHintY = 470
var solutionMoveDescriptionY = 505


// arrows
var arrowDimension = 238 * scaleFactor

var arrowPositions = {
    "UL": {
        x: 185 * scaleFactor,
        y: 250 * scaleFactor + 20
    },
    "UR": {
        x: 49 * scaleFactor,
        y: 253 * scaleFactor + 20
    },
    "DL": {
        x: 188 * scaleFactor + 2,
        y: 354 * scaleFactor + 32
    },
    "DR": {
        x: 50 * scaleFactor -5,
        y: 357 * scaleFactor + 32
    },
    "LU": {
        x: 3 * scaleFactor - 10,
        y: 308 * scaleFactor +25
    },
    "LD": {
        x: 80 * scaleFactor - 10,
        y: 186 * scaleFactor + 25
    },
    "RU": {
        x: 97 * scaleFactor,
        y: 363 * scaleFactor + 20
    },
    "RD": {
        x: 170 * scaleFactor,
        y: 240 * scaleFactor + 20
    },
    "FC": {
        x: 58 * scaleFactor + 3,
        y: 245 * scaleFactor + 15
    },
    "FA": {
        x: 134 * scaleFactor + 3,
        y: 355 * scaleFactor + 20
    },
    "BC": {
        x: 155 * scaleFactor + 10,
        y: 190 * scaleFactor + 15
    },
    "BA": {
        x: 230 * scaleFactor + 10,
        y: 310 * scaleFactor + 15
    }
};
