import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Controls.Basic

import DataBase.h
import "qml"

ApplicationWindow {
    id: root

    width: 600
    height: 460
    minimumHeight: 420
    minimumWidth: 237
    visible: true
    title: qsTr("Persons Data")

    Material.theme: Material.System
    Material.primary: Material.System
    Material.accent: Material.BlueGrey
    Material.foreground: Material.Dark

    Component.onCompleted: {
        if(Qt.platform.os !== "windows" | "unix" | "osx") {
            root.flags = Qt.FramelessWindowHint
            root.showFullScreen()
        }
    }

    DataBase {
        id: db

    }

    OptionsMenu {
        id: optionsMenu

    }
    WarningDialog {
        id: warningDialog

    }

    Models {
        id: models

        Component.onCompleted: clear()
    }

    MainView {
        id: mainView

        visible: stack.currentItem === this
    }

    SaveView {
        id: saveView

        visible: stack.currentItem === this
    }

    StackView {
        id: stack

        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
            right: list.left
            rightMargin: 10
            leftMargin: 5
        }
        onCurrentItemChanged: {
            if(Qt.platform.os === "windows" | "unix" | "osx") {
                if(currentItem == mainView) {
                    root.width = 237
                    root.height = 460
                    root.flags = Qt.Window
                            | Qt.WindowMinimizeButtonHint
                            | Qt.WindowCloseButtonHint
                            | Qt.WindowTitleHint
                }
                else if(currentItem == saveView) {
                    root.width = 850
                    root.height = 420
                    root.flags = Qt.Window
                }
            }
        }

        initialItem: mainView

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 700
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 700
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 700
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 700
            }
        }
    }

    ListView {
        id: list


        antialiasing: true
        anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
        }
        width: parent.width - 200
        clip: true
        flickDeceleration: Flickable.VerticalFlick
        visible: stack.currentItem == saveView

        header: Text {
            id: headertxt
            text: qsTr("Items In Database")
            font.pixelSize: 14
            anchors.horizontalCenter: parent.horizontalCenter
        }
        model: models

        delegate: List_Component {}


    }

}
