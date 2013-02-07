#ifndef GLOBAL_H
#define GLOBAL_H

#include <QtCore/QObject>

class Global : public QObject
{
    Q_OBJECT

    Q_ENUMS(Platform)

    Q_PROPERTY(Global::Platform platform READ platform CONSTANT)
    Q_PROPERTY(qreal platformScale READ platformScale CONSTANT)
public:
    enum Platform {
        Symbian,
        Harmattan,
        BlackBerry10,
        Desktop
    };

    Global(QObject *parent = 0);

    Global::Platform platform() const;
    qreal platformScale() const;
};

#endif
