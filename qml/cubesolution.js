var solutionMap = undefined;
var moveIndex = 0;

var layers = {
    "UL": "Turn the top face to the left",
    "UR": "Turn the top face to the right",
    "DL": "Turn the bottom face to the left",
    "DR": "Turn the bottom face to the right",
    "LU": "Turn the left face up",
    "LD": "Turn the left face down",
    "RU": "Turn the right face up",
    "RD": "Turn the right face down",
    "FC": "Turn the front face clockwise",
    "FA": "Turn the front face counterclockwise",
    "BC": "Turn the back face clockwise",
    "BA": "Turn the back face counterclockwise"
};

function solve() {
    solutionMap = rubik.solve();
    var result = -1
    if (!solutionMap.solved) {
        //Cube not solved. Possibly mispainted.
        return result;
    }

    if (solutionMap.moves.length > 0){
        remainingMoves.text = moveIndex + "/" + solutionMap.moves.length;
        highlightNextMove();
        //Cube is solved and we have movements to do
        result = 1;
    } else {
        //Cube is solves and we don't have movements to do
        result = 0;
    }

    return result
}

function nextMove()
{
    if (moveIndex < solutionMap.moves.length) {
        rubik.rotate(solutionMap.moves[moveIndex++]);
    } else {
        console.log("no more moves, already at the end");
    }

    remainingMoves.text = moveIndex + "/" + solutionMap.moves.length;

    if (moveIndex === solutionMap.moves.length) {
        hideArrows();
        clearLayers();
    } else {
        if (moveIndex < solutionMap.moves.length) {
            highlightNextMove();
        }
    }
}

function previousMove()
{
    if (moveIndex > 0) {
        rubik.reverseRotate(solutionMap.moves[--moveIndex])
    } else {
        console.log("no more moves, already at the beginning");
    }

    remainingMoves.text = moveIndex + "/" + solutionMap.moves.length

    if (moveIndex < solutionMap.moves.length) {
        highlightNextMove();
    }
}

function highlightTopLayer()
{
    cube.faces.top.highlightAll();
    cube.faces.front.highlight([0, 1, 2]);
    cube.faces.right.highlight([0, 1, 2]);
}

function highlightBottomLayer()
{
    cube.faces.top.shadowAll();
    cube.faces.front.highlight([6, 7, 8]);
    cube.faces.right.highlight([6, 7, 8]);
}

function highlightLeftLayer()
{
    cube.faces.right.shadowAll();
    cube.faces.top.highlight([0, 3, 6]);
    cube.faces.front.highlight([0, 3, 6]);
}


function highlightRightLayer()
{
    cube.faces.right.highlightAll();
    cube.faces.front.highlight([2, 5, 8]);
    cube.faces.top.highlight([2, 5, 8]);
}


function highlightFrontLayer()
{
    cube.faces.front.highlightAll();
    cube.faces.top.highlight([6, 7, 8]);
    cube.faces.right.highlight([0, 3, 6]);
}

function highlightBackLayer()
{
    cube.faces.front.shadowAll();
    cube.faces.top.highlight([0, 1, 2]);
    cube.faces.right.highlight([2, 5, 8]);
}

function highlightMiddleHorizontalLayer()
{
    cube.faces.top.shadowAll();
    cube.faces.front.highlight([3, 4, 5]);
    cube.faces.right.highlight([3, 4, 5]);
}

function highlightMiddleVerticalLayer()
{
    cube.faces.right.shadowAll();
    cube.faces.top.highlight([1, 4, 7]);
    cube.faces.front.highlight([1, 4, 7]);
}

function highlightMiddleTransversalLayer()
{
    cube.faces.front.shadowAll();
    cube.faces.right.highlight([1, 4, 7]);
    cube.faces.top.highlight([3, 4, 5]);
}

function hideArrows()
{
    arrowHorizontalLeft.state = "hidden";
    arrowHorizontalRight.state = "hidden";
    arrowVerticalLeftUp.state = "hidden";
    arrowVerticalLeftDown.state = "hidden";
    arrowVerticalRightUp.state = "hidden";
    arrowVerticalRightDown.state = "hidden";
}

function showArrow(move)
{
    hideArrows()
    var arrow = undefined;

    switch (move) {
    case "UL":
        arrow = arrowHorizontalLeft;
        break;
    case "UR":
        arrow = arrowHorizontalRight;
        break;
    case "DL":
        arrow = arrowHorizontalLeft;
        break;
    case "DR":
        arrow = arrowHorizontalRight;
        break;
    case "LU":
        arrow = arrowVerticalLeftUp;
        break;
    case "LD":
        arrow = arrowVerticalLeftDown;
        break;
    case "RU":
        arrow = arrowVerticalLeftUp;
        break;
    case "RD":
        arrow = arrowVerticalLeftDown;
        break
    case "FC":
        arrow = arrowVerticalRightDown;
        break;
    case "FA":
        arrow = arrowVerticalRightUp;
        break;
    case "BC":
        arrow = arrowVerticalRightDown;
        break;
    case "BA":
        arrow = arrowVerticalRightUp;
        break;
    case "ML":
    case "MR":
    case "MU":
    case "MD":
    case "MC":
    case "MA":
    default:
        console.log("IMPLEMENT ME!!! move: " + move);
        break;
    }

    if (typeof arrow != "undefined") {
        arrow.x = Platform.arrowPositions[move].x;
        arrow.y = Platform.arrowPositions[move].y;
        arrow.state = "visible";
    }
}

function highlightNextMove()
{
    var move = solutionMap.moves[moveIndex];

    switch (move) {
    case "UL":
    case "UR":
        highlightTopLayer();
        break;
    case "DL":
    case "DR":
        highlightBottomLayer();
        break;
    case "LU":
    case "LD":
        highlightLeftLayer();
        break;
    case "RU":
    case "RD":
        highlightRightLayer();
        break
    case "FC":
    case "FA":
        highlightFrontLayer();
        break;
    case "BC":
    case "BA":
        highlightBackLayer();
        break;
    case "ML":
    case "MR":
        highlightMiddleHorizontalLayer();
        break;
    case "MU":
    case "MD":
        highlightMiddleVerticalLayer();
        break;
    case "MC":
    case "MA":
        highlightMiddleTransversalLayer();
        break;
    }

    moveDescription.text = layers[solutionMap.moves[moveIndex]];
    showArrow(move)

}

function returnFromSolution() {
    clearLayers();
    hideArrows()
    root.back()
}

function clearLayers()
{
    for (var f in cube.faces) {
        cube.faces[f].reset();
    }
}



