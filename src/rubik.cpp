#include "rubik.h"

#include <QtCore/QDebug>
#include <QtCore/QString>

Rubik::Rubik(QObject *parent)
    : QObject(parent)
    , topFaceModel(new RubikFaceModel(&m_cube, TopFace, this))
    , leftFaceModel(new RubikFaceModel(&m_cube, LeftFace, this))
    , frontFaceModel(new RubikFaceModel(&m_cube, FrontFace, this))
    , rightFaceModel(new RubikFaceModel(&m_cube, RightFace, this))
    , backFaceModel(new RubikFaceModel(&m_cube, BackFace, this))
    , bottomFaceModel(new RubikFaceModel(&m_cube, BottomFace, this))
{
    initializeRotationsHash();

    // this is to help when we need to operate over all faces at once
    // i.e. for deleting and emiting signals
    m_faces.append(topFaceModel);
    m_faces.append(leftFaceModel);
    m_faces.append(frontFaceModel);
    m_faces.append(rightFaceModel);
    m_faces.append(backFaceModel);
    m_faces.append(bottomFaceModel);

    reset();
}

Rubik::~Rubik()
{
    for (int i = 0; i < m_faces.size(); i++) {
        delete m_faces[i];
    }
}

void Rubik::initializeRotationsHash()
{
    m_rotations["UL"] = TopLeft;
    m_rotations["UR"] = TopRight;
    m_rotations["DL"] = BottomLeft;
    m_rotations["DR"] = BottomRight;
    m_rotations["LU"] = LeftUp;
    m_rotations["LD"] = LeftDown;
    m_rotations["RU"] = RightUp;
    m_rotations["RD"] = RightDown;
    m_rotations["FC"] = FrontClockwise;
    m_rotations["FA"] = FrontCounterClockwise;
    m_rotations["BC"] = BackClockwise;
    m_rotations["BA"] = BackCounterclockwise;
    m_rotations["ML"] = MiddleLeft;
    m_rotations["MR"] = MiddleRight;
    m_rotations["MU"] = MiddleUp;
    m_rotations["MD"] = MiddleDown;
    m_rotations["MC"] = MiddleClockwise;
    m_rotations["MA"] = MiddleCounterclockwise;
    m_rotations["CL"] = WholeCubeLeft;
    m_rotations["CR"] = WholeCubeRight;
    m_rotations["CU"] = WholeCubeUp;
    m_rotations["CD"] = WholeCubeDown;
    m_rotations["CC"] = WholeCubeClockwise;
    m_rotations["CA"] = WholeCubeCounterclockwise;
}

QVariantMap Rubik::solve()
{
    QVariantMap ret;

    // Cubex sets this variable to false whenever there is a problem,
    // and in our case, if it fails once, it always will, because
    // SolveCube() will just return if cubeinit is false, so we set
    // it to true whenever we try to solve the cube.
    m_cube.cubeinit = true;
    m_cube.shorten = true;
    m_cube.cenfix = false;

    int cubeRet = m_cube.SolveCube();
    if (cubeRet != 0) {
        ret.insert("solved", false);
        ret.insert("error", getErrorMap(cubeRet));
    } else {
        qDebug() << m_cube.MOV;
        for (int i = 0; i < m_cube.MOV; i++) {
            qDebug() << "mov [" << i <<"]: " << m_cube.mov[i];
        }
        ret.insert("solved", true);
        ret.insert("moves", getSolutionMoves());
    }

    return ret;
}

QStringList Rubik::getSolutionMoves()
{
    QString moves = QString(m_cube.solution.c_str()).toUpper();
    QChar separator = '.';
    QStringList ret = moves.split(separator, QString::SkipEmptyParts);

    return ret;
}

QVariantMap Rubik::getErrorMap(int status)
{
    QVariantMap errorMap;
    QString failReason;
    CubeError error;

    switch (status) {
    case 1:
        error = CubeletErrorIncorrectCubelets;
        failReason = "Cubelet error - incorrect cubelets - cube mispainted";
        break;
    case 2:
        error = ParityErrorNonDescript;
        failReason = "Parity error - nondescript - cube misassembled";
        break;
    case 3:
        error = ParityErrorCenterRotation;
        failReason = "Parity error - center rotation - cube misassembled";
        break;
    case 4:
        error = CubeletErrorBackwardCentersOrCorners;
        failReason = "Cubelet error - backward centers or corners - cube mispainted";
        break;
    case 5:
        error = ParityErrorEdgeFlipping;
        failReason = "Parity error - edgle flipping - cube misassembled";
        break;
    case 6:
        error = ParityErrorEdgeSwapping;
        failReason = "Parity error - edge swapping - cube misassembled";
        break;
    case 7:
        error = ParityErrorCornerRotation;
        failReason = "Parity error - corner rotation - cube misassembled";
        break;
    default:
        error = NoError;
        failReason = "No Error";
    }

    errorMap.insert("code", error);
    errorMap.insert("message", failReason);

    return errorMap;
}

void Rubik::rotate(Rotation rotation)
{
    switch (rotation) {
    case None:
        // does nothing
        qDebug() << "NONE";
        break;
    case TopLeft:
        m_cube.UL();
        break;
    case TopRight:
        m_cube.UR();
        break;
    case BottomLeft:
        m_cube.DL();
        break;
    case BottomRight:
        m_cube.DR();
        break;
    case LeftUp:
        m_cube.LU();
        break;
    case LeftDown:
        m_cube.LD();
        break;
    case RightUp:
        m_cube.RU();
        break;
    case RightDown:
        m_cube.RD();
        break;
    case FrontClockwise:
        m_cube.FC();
        break;
    case FrontCounterClockwise:
        m_cube.FA();
        break;
    case BackClockwise:
        m_cube.BC();
        break;
    case BackCounterclockwise:
        m_cube.BA();
        break;
    case MiddleLeft:
        m_cube.ML();
        break;
    case MiddleRight:
        m_cube.MR();
        break;
    case MiddleUp:
        m_cube.MU();
        break;
    case MiddleDown:
        m_cube.MD();
        break;
    case MiddleClockwise:
        m_cube.MC();
        break;
    case MiddleCounterclockwise:
        m_cube.MA();
        break;
    case WholeCubeLeft:
        m_cube.CL();
        break;
    case WholeCubeRight:
        m_cube.CR();
        break;
    case WholeCubeUp:
        m_cube.CU();
        break;
    case WholeCubeDown:
        m_cube.CD();
        break;
    case WholeCubeClockwise:
        m_cube.CC();
        break;
    case WholeCubeCounterclockwise:
        m_cube.CA();
        break;
    default:
        qDebug() << "srsly, so many moves to choose from and you do this...";
        break;
    }
}

Rubik::Rotation Rubik::getReverseRotation(QString rotation)
{
    Rotation ret = None;
    if (m_rotations.contains(rotation.toUpper())) {
        Rotation current = m_rotations[rotation.toUpper()];
        switch (current) {
        case TopLeft:
            ret = TopRight;
            break;
        case TopRight:
            ret  = TopLeft;
            break;
        case BottomLeft:
            ret = BottomRight;
            break;
        case BottomRight:
            ret = BottomLeft;
            break;
        case LeftUp:
            ret = LeftDown;
            break;
        case LeftDown:
            ret = LeftUp;
            break;
        case RightUp:
            ret = RightDown;
            break;
        case RightDown:
            ret = RightUp;
            break;
        case FrontClockwise:
            ret = FrontCounterClockwise;
            break;
        case FrontCounterClockwise:
            ret = FrontClockwise;
            break;
        case BackClockwise:
            ret = BackCounterclockwise;
            break;
        case BackCounterclockwise:
            ret = BackClockwise;
            break;
        case MiddleLeft:
            ret = MiddleRight;
            break;
        case MiddleRight:
            ret = MiddleLeft;
            break;
        case MiddleUp:
            ret = MiddleDown;
            break;
        case MiddleDown:
            ret = MiddleUp;
            break;
        case MiddleClockwise:
            ret = MiddleCounterclockwise;
            break;
        case MiddleCounterclockwise:
            ret = MiddleClockwise;
            break;
        case WholeCubeLeft:
            ret = WholeCubeRight;
            break;
        case WholeCubeRight:
            ret = WholeCubeLeft;
            break;
        case WholeCubeUp:
            ret = WholeCubeDown;
            break;
        case WholeCubeDown:
            ret = WholeCubeUp;
            break;
        case WholeCubeClockwise:
            ret = WholeCubeCounterclockwise;
            break;
        case WholeCubeCounterclockwise:
            ret = WholeCubeClockwise;
            break;
        case None:
        default:
            ret = None;
            break;
        }
    }
    return ret;
}

void Rubik::rotate(QString rotation)
{
    if (m_rotations.contains(rotation.toUpper())) {
        notifyModelsBeforeChange();
        rotate(m_rotations[rotation.toUpper()]);
        notifyModelsAfterChange();
    }
}

void Rubik::reverseRotate(QString rotation)
{
    notifyModelsBeforeChange();
    rotate(getReverseRotation(rotation));
    notifyModelsAfterChange();
}

void Rubik::notifyModelsBeforeChange()
{
    for (int i = 0; i < m_faces.size(); i++) {
        m_faces[i]->notifyLayoutAboutToBeChanged();
    }
}

void Rubik::notifyModelsAfterChange()
{
    for (int i = 0; i < m_faces.size(); i++) {
        m_faces[i]->notifyLayoutChanged();
    }
}

void Rubik::reset()
{
    notifyModelsBeforeChange();
    // XXX: should instead call resetCube(), which leaves the cube in a
    // "solved" state?
    // m_cube.ResetCube();
    for (int i = 0; i < m_faces.size(); i++) {
        for (int j = 0; j < 9; j++) {
            // XXX: fragile: "1" is supposed to be the white color
            *m_faces[i]->getSticker(j) = 1;
        }
    }

    notifyModelsAfterChange();
}

void Rubik::scramble()
{
    notifyModelsBeforeChange();
    m_cube.ScrambleCube();
    notifyModelsAfterChange();
}
