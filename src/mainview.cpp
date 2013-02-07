#include "mainview.h"

#include "rubik.h"
#include "shear.h"

#include <QtDeclarative>
#include <QtDeclarative/QDeclarativeContext>
#include <QtDeclarative/QDeclarativeView>
#include <QtDeclarative/QDeclarativeEngine>

MainView::MainView(QWidget *parent)
    : QDeclarativeView(parent)
    , m_context(rootContext())
{
    setRenderHint(QPainter::Antialiasing);
    setRenderHint(QPainter::SmoothPixmapTransform);

    connect(engine(), SIGNAL(quit()), SLOT(close()));

    qmlRegisterType<QGraphicsBlurEffect>("Effects",1,0,"Blur");
    qmlRegisterType<Shear>("RubikCube", 1, 0, "Shear");

    Rubik *rubik = new Rubik(this);

    m_context->setContextProperty("rubikTopFaceModel", rubik->topFaceModel);
    m_context->setContextProperty("rubikLeftFaceModel", rubik->leftFaceModel);
    m_context->setContextProperty("rubikFrontFaceModel", rubik->frontFaceModel);
    m_context->setContextProperty("rubikRightFaceModel", rubik->rightFaceModel);
    m_context->setContextProperty("rubikBackFaceModel", rubik->backFaceModel);
    m_context->setContextProperty("rubikBottomFaceModel", rubik->bottomFaceModel);
    m_context->setContextProperty("rubik", rubik);

    setSource(QUrl("qrc:/qml/main.qml"));
    setResizeMode(QDeclarativeView::SizeRootObjectToView);
}

MainView::~MainView()
{
}
