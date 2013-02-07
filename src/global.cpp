#include "global.h"

Global::Global(QObject *parent)
    : QObject(parent)
{
}

Global::Platform Global::platform() const
{
#if defined(Q_OS_SYMBIAN)
    return Symbian;
#elif defined(MEEGO_HARMATTAN)
    return Harmattan;
#elif defined(XXX_BLACKBERRY10)
    return BlackBerry10;
#else
    return Desktop;
#endif
}


qreal Global::platformScale() const
{
#if defined(Q_OS_SYMBIAN)
    return 0.75;
#elif defined(MEEGO_HARMATTAN)
    return 1.0;
#elif defined(XXX_BLACKBERRY10)
    return 1.0;
#else
    // desktop
    return 0.75; // testing symbian
#endif
}
