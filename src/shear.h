#ifndef SHEAR_H
#define SHEAR_H

#include <QtDeclarative/QDeclarativeItem>

class Shear : public QDeclarativeItem
{
    Q_OBJECT
    Q_PROPERTY(qreal horizontalFactor READ horizontalFactor WRITE setHorizontalFactor NOTIFY horizontalFactorChanged)
    Q_PROPERTY(qreal verticalFactor READ verticalFactor WRITE setVerticalFactor NOTIFY verticalFactorChanged)

public:
    Shear(QDeclarativeItem *parent = 0);

    qreal horizontalFactor() const { return m_horizontalFactor; }
    void setHorizontalFactor(qreal factor);

    qreal verticalFactor() const { return m_verticalFactor; }
    void setVerticalFactor(qreal factor);

signals:
    void horizontalFactorChanged();
    void verticalFactorChanged();

private:
    void updateShear();

    qreal m_horizontalFactor;
    qreal m_verticalFactor;
};

#endif

