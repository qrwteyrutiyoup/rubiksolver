function shadowOtherFaces(currentFace) {
    cube.background.opacity = 0.0;

    for (var face in cube.faces) {
        var faceName = face + "Face"
        // XXX: Fix this quickly.
        if (currentFace.objectName === faceName) {
            miniCube.faces[face].state = "";
            miniCube.faces[face].z = 10;
            cube.faces[face].state = "highlighted";
            continue;
        }

        miniCube.faces[face].state = "shadowed";
        miniCube.faces[face].z = 1;
        cube.faces[face].state = "shadowed";
    }
}

function restoreFaces() {
    cube.background.opacity = 1.0;

    for (var face in cube.faces) {
        miniCube.faces[face].state = "";
        cube.faces[face].state = "";
    }
}

function scramble() {
    rubik.scramble();
}

function reset() {
    rubik.reset();
}

