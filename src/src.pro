PROJECTNAME = RubikSolver

TEMPLATE = app
TARGET = rubiksolver
VERSION = 0.1

QT += declarative opengl

CONFIG += mobility
MOBILITY += multimedia

include(solver/solver.pri)

# For Nokia Store builds
# also uncomment the line symbian:DEPLOYMENT.installer_header when building
#UID3 = 200651B5

# For development use (self-signed)
UID3 = E63942F9

symbian:TARGET.UID3 = 0x$$UID3

# Smart Installer package's UID
# This UID is from the protected range and therefore the package will
# fail to install if self-signed. By default qmake uses the unprotected
# range value if unprotected UID is defined for the application and
# 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Allow network access on Symbian
# symbian:TARGET.CAPABILITY += NetworkServices

CONFIG(release, debug|release) {
    DEFINES += QT_NO_DEBUG_OUTPUT QT_NO_WARNING_OUTPUT
}

symbian {
    CONFIG += qt-components

    LIBS += \
	-lesock \
	-lconnmon \
	-lcone \
	-lavkon

    TARGET.UID3 = 0xE5C40926
    TARGET.EPOCHEAPSIZE = 0x20000 0x8000000
    TARGET.EPOCSTACKSIZE = 0x14000

    symbian-abld|symbian-sbsv2 {
	# ro-section in gui can exceed default allocated space,
	# so move rw-section a little further
	QMAKE_LFLAGS.ARMCC += --rw-base 0x800000
	QMAKE_LFLAGS.GCCE += -Tdata 0xC00000
    }

    ICON = ../data/RubikSolver.svg
    font.sources = ../font/BebasNeue.ttf
    font.path = c:\\system\\apps\\$$TARGET.UID3
    DEPLOYMENT += font
    DEFINES += RUBIK_UID=\"$$replace(TARGET.UID3, 0x,)\"
    RESOURCES += ../qml/symbian/symbian.qrc
    MMP_RULES += "DEBUGGABLE"
} else {
    RESOURCES += ../font/font.qrc
}

RESOURCES += \
    ../qml/qml.qrc \
    ../img/img.qrc

contains(MEEGO_EDITION,harmattan) {
    DEFINES += MEEGO_EDITION_HARMATTAN
    RESOURCES += ../qml/harmattan/harmattan.qrc
}

unix:!symbian {


    isEmpty(PREFIX) {
	contains(MEEGO_EDITION,harmattan) {
	    PREFIX = /opt/rubiksolver
	} else {
	    PREFIX = /usr/local
	}
    }
    RESOURCES += ../qml/generic/generic.qrc
    target.path = $$PREFIX/bin
    INSTALLS += target
}

HEADERS += \
    $$PWD/mainview.h \
    $$PWD/rubikfacemodel.h \
    $$PWD/rubik.h \
    $$PWD/shear.h

SOURCES += \
    $$PWD/main.cpp \
    $$PWD/mainview.cpp \
    $$PWD/rubik.cpp \
    $$PWD/rubikfacemodel.cpp \
    $$PWD/shear.cpp

