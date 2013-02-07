#include <QtGui/QApplication>
#include <QtGui/QDesktopWidget>
#include <QtGui/QFontDatabase>
#include <QtCore/QUrl>
#include <QtCore/QFile>
#include <QtCore/QDebug>
#include "mainview.h"
#include <stdio.h>
Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName("Sergio Correia");
    QCoreApplication::setApplicationName("Rubik Solver");

    QApplication app(argc, argv);

#ifdef Q_OS_SYMBIAN
    QString font("c:\\system\\apps\\0x"RUBIK_UID"\\BebasNeue.ttf");
#else
    QString font(":/font/BebasNeue.ttf");
#endif
    QFontDatabase::addApplicationFont(font);

    MainView view;

#if defined(Q_OS_SYMBIAN) || defined(QT_SIMULATOR) || defined(MEEGO_EDITION_HARMATTAN)
    QSize windowSize;
    windowSize.setWidth(QApplication::desktop()->screenGeometry().width());
    windowSize.setHeight(QApplication::desktop()->screenGeometry().height());
    view.resize(windowSize);


    view.showFullScreen();
#else
    view.setFixedSize(480, 800);
    view.show();
#endif

    return app.exec();
}
