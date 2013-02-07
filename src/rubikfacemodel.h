#ifndef RUBIKFACEMODEL_H
#define RUBIKFACEMODEL_H

#include <QtCore/QObject>
#include <QtCore/QAbstractListModel>

#include "solver/cubex.h"

enum RubikFace {
    TopFace = 0,
    LeftFace,
    FrontFace,
    RightFace,
    BackFace,
    BottomFace
};

class RubikFaceModel: public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        ColorIndex = Qt::UserRole + 1
    };

    RubikFaceModel(Cubex *cube, RubikFace face, QObject *parent = 0);
    ~RubikFaceModel();

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = ColorIndex) const;
    Qt::ItemFlags flags(const QModelIndex &index) const;
    bool setData(const QModelIndex &index, const QVariant &value, int role);

    Q_INVOKABLE bool setColorIndex(int index, const QVariant &value);

    void notifyLayoutAboutToBeChanged();
    void notifyLayoutChanged();

    int *getSticker(int) const;

private:
    Cubex *m_cube;
    RubikFace m_face;
};


#endif // RUBIK_H
