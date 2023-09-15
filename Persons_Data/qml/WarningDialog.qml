import QtQuick
import Qt.labs.platform

Item {

    property alias emptyField: emptyField
    property alias sqlError: sqlError
    property alias queryError: queryError
    property alias inserted: inserted
    property string sql_err
    property string query_err

    Connections {
        target: db
        function onSql_ErrorChanged() {
            sql_err = db.sql_error
        }
        function onQuery_ErrorChanged() {
            query_err = db.query_error
        }
    }

    MessageDialog {
        id: emptyField

        buttons: MessageDialog.Ok
        text: qsTr("<html><font color='green'><h1 style='font-size:4vw'>Warning !</h1></font></html>")
        informativeText: qsTr("<html><font color='red'><h1 style='font-family:Bahnschrift SemiBold'; style='font-size:5vw'>Please Fill All Text Field</h1></font></html>")
        modality: Qt.WindowModal
        flags: Qt.FramelessWindowHint | Qt.Dialog
    }
    MessageDialog {
        id: sqlError

        buttons: MessageDialog.Ok
        text: qsTr("<html><font color='red'><h1 style='font-size:4vw'>Error: </h1></font></html>")
        informativeText: qsTr("<html><font color='red'><h1 style='font-family:Bahnschrift SemiBold'; style='font-size:5vw'>" + sql_err)
        modality: Qt.WindowModal
        flags: Qt.FramelessWindowHint | Qt.Dialog
    }
    MessageDialog {
        id: queryError

        buttons: MessageDialog.Ok
        text: qsTr("<html><font color='red'><h1 style='font-size:4vw'>Error: </h1></font></html>")
        informativeText: qsTr("<html><font color='red'><h1 style='font-family:Bahnschrift SemiBold'; style='font-size:5vw'>" + query_err)
        modality: Qt.WindowModal
        flags: Qt.FramelessWindowHint | Qt.Dialog
    }
    MessageDialog {
        id: inserted

        buttons: MessageDialog.Ok
        text: qsTr("<html><font color='green'><h1 style='font-size:4vw'>Info: </h1></font></html>")
        informativeText: qsTr("<html><font color='green'><h1 style='font-family:Bahnschrift SemiBold'; style='font-size:5vw'>Data Inserted To The DataBase !")
        modality: Qt.WindowModal
        flags: Qt.FramelessWindowHint | Qt.Dialog
    }

}
