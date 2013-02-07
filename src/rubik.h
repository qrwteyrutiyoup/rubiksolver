#ifndef RUBIK_H
#define RUBIK_H

#include "rubikfacemodel.h"
#include "solver/cubex.h"

#include <QtCore/QObject>
#include <QtCore/QStringList>
#include <QtCore/QVariant>

class Rubik : public QObject
{
    Q_OBJECT

    Q_ENUMS(Rotation)
    Q_ENUMS(CubeError)

public:
    enum CubeError {
        CubeletErrorIncorrectCubelets = 0,
        ParityErrorNonDescript,
        ParityErrorCenterRotation,
        CubeletErrorBackwardCentersOrCorners,
        ParityErrorEdgeFlipping,
        ParityErrorEdgeSwapping,
        ParityErrorCornerRotation,
        NoError
    };

    enum Rotation {
        None = 0,
        TopLeft,                    /* UL */
        TopRight,                   /* UR */
        BottomLeft,                 /* DL */
        BottomRight,                /* DR */
        LeftUp,                     /* LU */
        LeftDown,                   /* LD */
        RightUp,                    /* RU */
        RightDown,                  /* RD */
        FrontClockwise,             /* FC */
        FrontCounterClockwise,      /* FA */
        BackClockwise,              /* BC */
        BackCounterclockwise,       /* BA */
        MiddleLeft,                 /* ML */
        MiddleRight,                /* MR */
        MiddleUp,                   /* MU */
        MiddleDown,                 /* MD */
        MiddleClockwise,            /* MC */
        MiddleCounterclockwise,     /* MA */
        WholeCubeLeft,              /* CL */
        WholeCubeRight,             /* CR */
        WholeCubeUp,                /* CU */
        WholeCubeDown,              /* CD */
        WholeCubeClockwise,         /* CC */
        WholeCubeCounterclockwise   /* CA */
    };

    Rubik(QObject *parent = 0);
    ~Rubik();

    RubikFaceModel *topFaceModel, *leftFaceModel, *frontFaceModel, *rightFaceModel, *backFaceModel, *bottomFaceModel;

    Q_INVOKABLE QVariantMap solve();
    Q_INVOKABLE void reset();
    Q_INVOKABLE void scramble();
    Q_INVOKABLE void rotate(QString rotation);
    Q_INVOKABLE void reverseRotate(QString rotation);

private:
    Cubex m_cube;
    QHash<QString, Rotation> m_rotations;
    QList<RubikFaceModel*> m_faces;

    void rotate(Rotation);
    Rotation getReverseRotation(QString);
    QVariantMap getErrorMap(int);
    QStringList getSolutionMoves();
    void initializeRotationsHash();
    void notifyModelsBeforeChange();
    void notifyModelsAfterChange();
};

#endif // RUBIK_H
