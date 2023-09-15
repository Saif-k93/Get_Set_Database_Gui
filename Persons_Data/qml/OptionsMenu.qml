import QtQuick
import Qt.labs.platform

Menu {
    MenuItem {
        text: qsTr("Undo")
        shortcut: StandardKey.Undo
        onTriggered: activeFocusItem.undo()
    }
    MenuItem {
        text: qsTr("Redo")
        shortcut: StandardKey.Redo
        onTriggered: activeFocusItem.redo()
    }
    MenuItem {
        separator: true
    }
    MenuItem {
        text: qsTr("Select All")
        shortcut: StandardKey.SelectAll
        onTriggered: activeFocusItem.selectAll()
    }
    MenuItem {
        separator: true
    }
    MenuItem {
        text: qsTr("Cut")
        shortcut: StandardKey.Cut
        onTriggered: activeFocusItem.cut()
    }
    MenuItem {
        text: qsTr("Copy")
        shortcut: StandardKey.Copy
        onTriggered: activeFocusItem.copy()
    }

    MenuItem {
        text: qsTr("Past")
        shortcut: StandardKey.Paste
        onTriggered: activeFocusItem.paste()
    }
}
