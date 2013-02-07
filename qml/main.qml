import QtQuick 1.1

RubikWindow {
    initialPage: mainPage
    showStatusBar: false
    showToolBar: false

    RubikPage {
        id: mainPage

        MainWindow {
            width: parent.width
            height: parent.height
        }
    }
}

