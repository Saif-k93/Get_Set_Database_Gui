import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material



Item {
    antialiasing: true

    Column {
        anchors.fill: parent
        transform: Translate {x:20}

        spacing: 6

        TextField {
            id: plugin

            topInset: 10
            height: 50
            width: parent.width
            font.pixelSize: 13
            placeholderText: qsTr("Plugin")
            validator: RegularExpressionValidator {regularExpression: /[a-z A-Z]{10}/}
            text: qsTr("QPSQL")

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onReleased: optionsMenu.open()
                cursorShape: parent.activeFocus ? Qt.IBeamCursor : Qt.ArrowCursor
            }
        }
        TextField {
            id: database
            height: 50
            width: parent.width
            font.pixelSize: 13
            placeholderText: qsTr("Database Name")
            text: qsTr("")
            validator: RegularExpressionValidator {regularExpression: /[a-z A-Z 0-9 _-]{50}/}

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onReleased: optionsMenu.open()
                cursorShape: parent.activeFocus ? Qt.IBeamCursor : Qt.ArrowCursor
            }
        }
        TextField {
            id: hostname

            height: 50
            width: parent.width
            font.pixelSize: 13
            placeholderText: qsTr("Host Name")
            text: qsTr("127.0.0.1")
            validator: RegularExpressionValidator {regularExpression: /[a-z A-Z 0-9 .]{50}/}

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onReleased: optionsMenu.open()
                cursorShape: parent.activeFocus ? Qt.IBeamCursor : Qt.ArrowCursor
            }
        }
        TextField {
            id: port

            height: 50
            width: parent.width
            font.pixelSize: 13
            placeholderText: qsTr("Port")
            text: qsTr("5432")
            validator: RegularExpressionValidator {regularExpression: /[0-9]{10}/}

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onReleased: optionsMenu.open()
                cursorShape: parent.activeFocus ? Qt.IBeamCursor : Qt.ArrowCursor
            }
        }
        TextField {
            id: username

            height: 50
            width: parent.width
            font.pixelSize: 13
            placeholderText: qsTr("Username")
            text: "postgres"
            validator: RegularExpressionValidator {regularExpression: /[a-z A-Z 0-9]{50}/}

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onReleased: optionsMenu.open()
                cursorShape: parent.activeFocus ? Qt.IBeamCursor : Qt.ArrowCursor
            }
        }
        TextField {
            id: password

            height: 50
            width: parent.width
            font.pixelSize: 13
            placeholderText: qsTr("Password")
            onLengthChanged: if(length === 0) {
                                 placeholderText = qsTr("Password")
                             } else
                                 placeholderText = qsTr("Password ( " + length + " )")

            text: qsTr("123456")
            validator: RegularExpressionValidator {regularExpression: /[^\s*]{64}/}
            echoMode: dispPass.down ? TextField.Normal : TextField.Password
            rightPadding: dispPass.width * 1.3

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onReleased: optionsMenu.open()
                cursorShape: parent.activeFocus ? Qt.IBeamCursor : Qt.ArrowCursor
            }

            RoundButton {
                id: dispPass

                width: 45
                height: 45
                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 10
                }
                font.pixelSize: 10
                icon.source: password.echoMode === TextField.Password ? "qrc:/img/close-eye.png" : "qrc:/img/viewPass.png"
                visible: password.text
            }
        }

        TextField {
            id: table_name

            height: 45
            width: parent.width
            font.pixelSize: 14
            placeholderText: qsTr("Table Name")
            text: qsTr("")
            validator: RegularExpressionValidator {regularExpression: /[a-z A-Z 0-9 -_]{50}/}

            background: Rectangle {
                radius: 10
                clip: true
                color: Qt.darker("white", 1.1)
                border.color: table_name.activeFocus ? "lightblue" : "transparent"
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onReleased: optionsMenu.open()
                cursorShape: parent.activeFocus ? Qt.IBeamCursor : Qt.ArrowCursor
            }
        }
        Button {
            id: connect

            width: parent.width
            text: qsTr("Connect To DataBase")
            Material.background: Qt.lighter("blue", 1.5)
            Material.foreground: down ? Qt.darker("white", 1.5) : Qt.darker("white", 1.03)
            Material.roundedScale: Material.FullScale
            Material.elevation: down ? 0 : 10

            icon.source: "qrc:/img/save.png"

            property string sep: ""

            onReleased: {
                if(!database.text | !hostname.text | !port.text | !username.text | !password.text | !table_name.text) {
                   warningDialog.emptyField.open()
                    return
                }
                db.table_name = table_name.text
                var ok = db.connect(plugin.text, database.text, hostname.text, port.text, username.text, password.text)
                if(!ok) {
                    connect.text = qsTr("Sql Connection Failed\nTry Again !")
                    warningDialog.sqlError.open()
                }
                else {
                    stack.push(saveView)
                    connect.text = qsTr("Connect To DataBase")
                    var first_name_list = db.get_first_name()
                    var last_name_list = db.get_last_name()
                    var age_list = db.get_age()
                    var address_list = db.get_address()
                    var phone_list = db.get_phone_number()
                    for(let i = 0; i < first_name_list.length; i++) {
                        models.append({"first_name": first_name_list[i],
                                          "last_name": last_name_list[i],
                                          "age": age_list[i].toString(),
                                          "address":address_list[i],
                                          "phone_number":phone_list[i] ,
                                      })
                    }
                }
            }
        }

    }
}
