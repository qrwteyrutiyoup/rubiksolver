#include "rubikfacemodel.h"
#include <QtCore/QDebug>

RubikFaceModel::RubikFaceModel(Cubex *cube, RubikFace face, QObject *parent)
    : QAbstractListModel(parent),
      m_cube(cube),
      m_face(face)
{
    m_roles[ColorIndex] = "colorIndex";
}

RubikFaceModel::~RubikFaceModel()
{
}

QHash<int,QByteArray> RubikFaceModel::roleNames() const
{
    return m_roles;
}

int RubikFaceModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_cube->N * m_cube->N;
}

QVariant RubikFaceModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= (m_cube->N * m_cube->N))
        return QVariant();

    switch (role) {
    case ColorIndex:
        return QVariant(*getSticker(index.row()));
    default:
        return QVariant();
    }
}

Qt::ItemFlags RubikFaceModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::ItemIsEnabled;

    return QAbstractItemModel::flags(index) | Qt::ItemIsEditable | Qt::ItemIsEnabled;
}

bool RubikFaceModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    bool ret = false;
    if (index.row() < 0 || index.row() >= (m_cube->N * m_cube->N))
        return ret;

    switch (role) {
    case ColorIndex:
        bool ok;
        int newData = value.toInt(&ok);
        if (ok) {
            int *currentData = getSticker(index.row());
            if (*currentData != newData) {
                *currentData = newData;
                emit dataChanged(index, index);
                ret = true;
            }
        }
    }
    return ret;
}

bool RubikFaceModel::setColorIndex(int index, const QVariant &value)
{
    qDebug() << __FUNCTION__;
    return setData(this->index(index), value, ColorIndex);
}

int *RubikFaceModel::getSticker(int index) const
{
    /* Warning: Very scary function(s).
     * Modify at your own risk
     *
     * (above comment from gtktreeview.c (hint: look for gtk_tree_view_bin_draw())
     *
     * for (int i = -1; i <= 1; i++) {
     *   for (int j = -1; j <= 1; j++) {
     *     *thecube.face(j, 2, -i) = TOP
     *     *thecube.face(-2, -i, -j) = LEFT
     *     *thecube.face(j, -i, -2) = FRONT
     *     *thecube.face(2, -i, j) = RIGHT
     *     *thecube.face(-j, -i, 2) = BACK
     *     *thecube.face(j, -2, i) = BOTTOM
     *   }
     * }
     *
     */

    int *ret = 0;
    if (index < 0 || index >= 9)
        return ret;

    int i = index < 3 ? -1 : index < 6 ? 0 : 1;
    int j = (index % 3) - 1;

    switch (m_face) {
    case TopFace:
        ret = m_cube->face(j, 2, -i);
        break;
    case LeftFace:
        ret = m_cube->face(-2, -i, -j);
        break;
    case FrontFace:
        ret = m_cube->face(j, -i, -2);
        break;
    case RightFace:
        ret = m_cube->face(2, -i, j);
        break;
    case BackFace:
        ret = m_cube->face(-j, -i, 2);
        break;
    case BottomFace:
        ret = m_cube->face(j, -2, i);
        break;
    default:
        break;
    }

    return ret;
}

void RubikFaceModel::notifyLayoutAboutToBeChanged()
{
    emit layoutAboutToBeChanged();
}

void RubikFaceModel::notifyLayoutChanged()
{
    emit layoutChanged();
}
