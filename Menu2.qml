import QtQuick 2.15
import QtQuick.Controls 2.15
//import QtQuick.Dialogs 1.3
import Qt.labs.platform 1.1

Item {
    id: menu2
    width: 0.3 * window.width
    //    anchors.left: parent.left
    x: -menu2.width
    anchors.bottom: parent.bottom
    anchors.top: parent.top
    Rectangle {
        id: menuElement
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "#eeeeee"
            }
            GradientStop {
                position: 1.0
                color: "#cccccc"
            }
        }
        anchors.fill: parent
        Column {
            id: menuColumn
            //            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 5
            spacing: 5
            Row {
                spacing: 5
                anchors.right: parent.right
                Button {
                    text: "Rule Color"
                    onClicked: colorDialog2.open()
                }
                ColorDialog {
                    id: colorDialog2
                    currentColor: fb.schemeColor
                    onAccepted: fb.schemeColor = colorDialog2.color
                }
                Button {
                    text: "Background Color"
                    onClicked: colorDialog3.open()
                }
                ColorDialog {
                    id: colorDialog3
                    currentColor: window.bgColor
                    onAccepted: window.bgColor = colorDialog3.color
                }
            }
            Column {
                anchors.right: parent.right
                //                spacing: thickness.width
                Text {
                    text: qsTr("Length")
                }
                TextField {
                    id: length
                    text: fb.length
                    //                    width: 0.485 * menu2.width
//                    validator: RegExpValidator {
//                        regExp: /[0-9]+/
//                    }
                    inputMask: "99"
                    onFocusChanged: {
                        if(focus){
                            cursorPosition=text.length
                        }
                    }
                }
            }
            Column {
                anchors.right: parent.right
                Text {
                    text: qsTr("Thickness")
                }
                TextField {
                    id: thickness
                    text: fb.thickness
                    //                    width: 0.485 * menu2.width
//                    validator: RegExpValidator {
//                        regExp: /[0-9]+/
//                    }
                    inputMask: "99"
                    onFocusChanged: {
                        if(focus){
                            cursorPosition=text.length
                        }
                    }
                }
            }
            Button {
                anchors.right: parent.right
                text: "Apply"
                onClicked: {
                    fb.length = length.text
                    fb.thickness = thickness.text
                }
            }
        }
        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            Text {
                fontSizeMode: Text.HorizontalFit
                anchors.margins: parent.width * 0.1
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                text: "Developed by Serhiienko Ihor"
                font.pointSize: 72
                font.family: customFont.name
            }
        }
    }
    Behavior on x {
        ParallelAnimation {
            PropertyAnimation {
                properties: "x"
                target: menu2
                duration: 500
            }
        }
    }
    Button {
        id: bookmark
        anchors.left: menu2.right
        anchors.verticalCenter: menu2.verticalCenter
        width: 35//hovered ? 35 : 10
        text: menu2.x == 0 ? "←" : "→"
        onClicked: menu2.x = menu2.x == 0 ? -menu2.width : 0
        Behavior on width {
            ParallelAnimation {
                PropertyAnimation {
                    properties: "width"
                    target: bookmark
                    duration: 200
                }
            }
        }
    }
}
