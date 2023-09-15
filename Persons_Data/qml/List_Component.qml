import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

Rectangle {
    id: mainRec

    width: list.width
    height: 45
    border.color: Qt.darker("white", 6)
    border.width: 2
    clip: true

    property string recColor: "lightgreen"
    Row {
        spacing: 5
        anchors {
            fill: parent
            margins: 5
        }
        clip: true

        Rectangle {
            width: fname.implicitWidth + 8
            anchors {
                top: parent.top
                bottom: parent.bottom
            }

            border.color: recColor
            border.width: 1
            Label {
                id: fname

                x:4
                y:4
                text: qsTr(first_name)
                font.pixelSize: 18
            }
        }

        Rectangle {
            width: lname.implicitWidth + 8
            anchors {
                top: parent.top
                bottom: parent.bottom
            }

            border.color: recColor
            border.width: 1
            Label {
                id: lname

                x:4
                y:4
                text: qsTr(last_name)
                font.pixelSize: 18
            }
        }
        Rectangle {
            width: m_age.implicitWidth + 8
            anchors {
                top: parent.top
                bottom: parent.bottom
            }

            border.color: recColor
            border.width: 1
            Label {
                id: m_age

                x:4
                y:4
                text: qsTr(age)
                font.pixelSize: 18
            }
        }
        Rectangle {
            width: m_address.implicitWidth + 8
            anchors {
                top: parent.top
                bottom: parent.bottom
            }

            border.color: recColor
            border.width: 1
            Label {
                id: m_address

                x:4
                y:4
                text: qsTr(address)
                font.pixelSize: 18
            }
        }
        Rectangle {
            width: m_phone_number.implicitWidth + 8
            anchors {
                top: parent.top
                bottom: parent.bottom
            }

            border.color: recColor
            border.width: 1
            Label {
                id: m_phone_number

                x:4
                y:4
                text: qsTr(phone_number)
                font.pixelSize: 18
            }
        }
    }
}
