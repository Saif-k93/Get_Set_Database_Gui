import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

Item {
    antialiasing: true

    Column {
        anchors.fill: parent
        spacing: 6

        TextField {
            id: fname

            topInset: 10
            height: 60
            width: parent.width
            font.pixelSize: 14
            placeholderText: qsTr("Enter Your first Name")
            validator: RegularExpressionValidator {regularExpression: /[a-z A-Z]{20}/}

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onReleased: optionsMenu.open()
                cursorShape: parent.activeFocus ? Qt.IBeamCursor : Qt.ArrowCursor
            }
        }
        TextField {
            id: sname

            height: 50
            width: parent.width
            font.pixelSize: 14
            placeholderText: qsTr("Enter Your Last Name")
            validator: RegularExpressionValidator {regularExpression: /[a-z A-Z]{20}/}

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onReleased: optionsMenu.open()
                cursorShape: parent.activeFocus ? Qt.IBeamCursor : Qt.ArrowCursor
            }
        }
        TextField {
            id: age

            height: 50
            width: parent.width
            font.pixelSize: 14
            placeholderText: qsTr("Enter Your Age")
            validator: RegularExpressionValidator {regularExpression: /[0-9]{3}/}

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onReleased: optionsMenu.open()
                cursorShape: parent.activeFocus ? Qt.IBeamCursor : Qt.ArrowCursor
            }
        }
        TextField {
            id: address

            height: 50
            width: parent.width
            font.pixelSize: 14
            placeholderText: qsTr("Enter Your address")
            validator: RegularExpressionValidator {regularExpression: /[a-z A-Z 0-9]{50}/}

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onReleased: optionsMenu.open()
                cursorShape: parent.activeFocus ? Qt.IBeamCursor : Qt.ArrowCursor
            }
        }
        TextField {
            id: phone

            height: 50
            width: parent.width
            font.pixelSize: 13
            placeholderText: qsTr("Enter Your Phone Number")
            validator: RegularExpressionValidator {regularExpression: /[0-9]{10}/}

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onReleased: optionsMenu.open()
                cursorShape: parent.activeFocus ? Qt.IBeamCursor : Qt.ArrowCursor
            }
        }

        Button {
            id: save

            width: parent.width
            text: qsTr("Save To DataBase")
            Material.background: Qt.lighter("blue", 1.5)
            Material.foreground: down ? Qt.darker("white", 1.5) : Qt.darker("white", 1.03)
            Material.roundedScale: Material.FullScale
            Material.elevation: down ? 0 : 10

            icon.source: "qrc:/img/save.png"

            property string sep: ""

            onReleased: {
                if(!fname.text | !sname.text | !age.text | !address.text | !phone.text) {
                      warningDialog.emptyField.open()
                    return
                }
                var ok = db.setData(fname.text, sname.text, age.text, address.text, phone.text)
                if(!ok) {
                    warningDialog.queryError.open()
                    return
                }
                    models.append({"first_name":fname.text, "last_name":sname.text, "age": age.text,
                                      "address": address.text, "phone_number": phone.text})
                    fname.clear(); sname.clear(); age.clear(); address.clear(); phone.clear()
                warningDialog.inserted.open()
            }
        }
        Button {
            id: disconnect

            width: parent.width
            text: qsTr("Disconnect\nAnd Go Back")
            Material.background: Qt.lighter("red", 1.5)
            Material.foreground: down ? Qt.darker("white", 1.5) : Qt.darker("white", 1.03)
            Material.roundedScale: Material.FullScale
            Material.elevation: down ? 0 : 10

            icon.source: "qrc:/img/save.png"

            property string sep: ""

            onReleased: {
                models.clear()
                db.disconnect()
                stack.pop()
            }
        }
    }
}
