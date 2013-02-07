#ifndef MAINVIEW_H
#define MAINVIEW_H

#include <QtDeclarative/QDeclarativeView>
#include <QtDeclarative/QDeclarativeContext>

class MainView : public QDeclarativeView
{
    Q_OBJECT

public:
    MainView(QWidget *parent = 0);
    ~MainView();

private:
    QDeclarativeContext *m_context;
};

#endif // MAINVIEW_H
