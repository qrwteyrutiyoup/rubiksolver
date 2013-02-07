#include "shear.h"

#include <QtGui/QPainter>

Shear::Shear(QDeclarativeItem *parent)
    : QDeclarativeItem(parent)
    , m_horizontalFactor(0.0)
    , m_verticalFactor(0.0)
{
}

void Shear::setHorizontalFactor(qreal factor)
{
    if (m_horizontalFactor == factor)
        return;

    m_horizontalFactor = factor;

    emit horizontalFactorChanged();

    updateShear();
}

void Shear::setVerticalFactor(qreal factor)
{
    if (m_verticalFactor == factor)
        return;

    m_verticalFactor = factor;

    emit verticalFactorChanged();

    updateShear();
}

void Shear::updateShear()
{
    QTransform t = QGraphicsItem::transform();
    t.shear(m_horizontalFactor, m_verticalFactor);
    setTransform(t);
}
