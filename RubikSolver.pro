TEMPLATE = subdirs
CONFIG += ordered

SUBDIRS += \
	$$PWD/src

# workarounds to generate Smart Installer via Qt SDK
symbian {
    coreinstaller.target = sub-c--weather-qml-src-installer_sis_target
    coreinstaller.commands = cd src && $(MAKE) installer_sis

    installer.target = installer_sis
    installer.depends = sub-c--weather-qml-src-installer_sis_target

    QMAKE_EXTRA_TARGETS += coreinstaller installer

} else:unix {
    include(data/data.pri)
}

OTHER_FILES += \
    $$PWD/font/* \
    $$PWD/img/* \
    $$PWD/qml/* \
    $$PWD/qml/rubik/* \
    $$PWD/qtc_packaging/debian_harmattan/changelog \
    $$PWD/qtc_packaging/debian_harmattan/compat \
    $$PWD/qtc_packaging/debian_harmattan/control \
    $$PWD/qtc_packaging/debian_harmattan/copyright \
    $$PWD/qtc_packaging/debian_harmattan/README \
    $$PWD/qtc_packaging/debian_harmattan/rules
