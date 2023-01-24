import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: menu
    property alias zoomSlider: slider
    width: 0.3 * window.width
    x: window.width - width
    //    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.top: parent.top
    Rectangle {
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
        id: menuElement
        anchors.fill: parent
        ScrollView {
            anchors.fill: parent
            clip: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            Column {
                id: menuColumn
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 5
                spacing: height*0.01


                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Axiom")
                    }
                    TextField {
                        id: axiomField
                        text: fb.axiom
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: menu.width*0.9
                        onTextChanged: {
                            for(var i =0; i<text.length; i++) {
                                if (text[i] !== "F" && text[i] !== "G" && text[i] !== "+" && text[i] !== "-") {
                                    if (text.length==1)
                                        text = ""
                                    else {
                                        text = text.slice(0, i) + text.slice(i+1, text.length-1)
                                    }
                                }
                            }
                        }
                        //                        validator: RegExpValidator {
                        //                            regExp: /[+/\-/\F/\G]+/
                        //                        }
                    }
                }

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        text: qsTr("Rule F")
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    TextField {
                        id: fField
                        text: fb.f
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: menu.width*0.9
                        onTextChanged: {
                            for(var i =0; i<text.length; i++) {
                                if (text[i] !== "F" && text[i] !== "G" && text[i] !== "+" && text[i] !== "-") {
                                    if (text.length==1)
                                        text = ""
                                    else {
                                        text = text.slice(0, i) + text.slice(i+1, text.length-1)
                                    }
                                }
                            }
                        }
                        //                        validator: RegExpValidator {
                        //                            regExp: /[+/\-/\F/\G]+/
                        //                        }
                    }
                }

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        text: qsTr("Rule G")
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    TextField {
                        id: gField
                        text: fb.g
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: menu.width*0.9
                        onTextChanged: {
                            for(var i =0; i<text.length; i++) {
                                if (text[i] !== "F" && text[i] !== "G" && text[i] !== "+" && text[i] !== "-") {
                                    if (text.length==1)
                                        text = ""
                                    else {
                                        text = text.slice(0, i) + text.slice(i+1, text.length-1)
                                    }
                                }
                            }
                        }
                        //                        validator: RegExpValidator {
                        //                            regExp: /[+/\-/\F/\G]+/
                        //                        }
                    }
                }

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        text: qsTr("Iteration")
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    TextField {
                        id: iterationField
                        text: fb.iteration
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: menu.width*0.9
                        inputMethodHints: Qt.ImhDialableCharactersOnly
                        inputMask: "99"
                        onFocusChanged: {
                            if(focus){
                                cursorPosition=text.length
                            }
                        }
                        //                        onTextEdited:
                        //                        validator: RegExpValidator {
                        //                            regExp: /[0-9]+/
                        //                        }
                    }
                }

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        text: qsTr("Angle")
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    TextField {
                        id: angleField
                        text: fb.deltaAngle
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: menu.width*0.9
                        inputMask: "999"
                        onFocusChanged: {
                            if(focus){
                                cursorPosition=text.length
                            }
                        }
                        //                        validator: RegExpValidator {
                        //                            regExp: /[0-9]+/
                        //                        }
                    }
                }

                Button {
                    text: "Proceed"
                    enabled: loading===100
                    onClicked: {
                        proceed()
                    }
                }
                Row {
                    Text {text: "Zoom"; anchors.verticalCenter: parent.verticalCenter; height: slider.height*0.7; font.pointSize: 72; fontSizeMode: Text.VerticalFit; width: contentWidth*1.1}
                    Slider {
                        id: slider
                        stepSize: 0.01
                        from: 0
                        to: 2
                        //                value: fb.scale
                        onPositionChanged: window.scaling(
                                               value, "absolute") //fb.scale = value
                    }}
                Column {
                    Row {
                        id: controllerRow
                        spacing: 21
                        Column {
                            Repeater {
                                model: 4
                                Row {
                                    id: row
                                    property int columnIndex: index
                                    Repeater {
                                        //                                        model: row.columnIndex
                                        //                                               == 0 ? ["↖️", "⬆️", "↗️"] : row.columnIndex
                                        //                                                      == 1 ? ["⬅️", "➕", "➡️"] : row.columnIndex
                                        //                                                             == 2 ? ["↙️", "⬇️", "↘️"] : ["↩️", "↪️"]
                                        model: row.columnIndex
                                               == 0 ? ["↖️", "↑", "↗️"] : row.columnIndex
                                                      == 1 ? ["←", "+", "→"] : row.columnIndex
                                                             == 2 ? ["↙️", "↓", "↘️"] : ["↺", "↻", parseInt(fb.rotation%360)]
                                        Button {
                                            height: 0.1 * menu.height
                                            width: height
                                            text: modelData
                                            onClicked: row.columnIndex * 3 + index === 0 ? [fb.y += 100, fb.x += 100] : row.columnIndex * 3 + index === 1 ? fb.y += 100 : row.columnIndex * 3 + index === 2 ? [fb.y += 100, fb.x -= 100] : row.columnIndex * 3 + index === 3 ? fb.x += 100 : row.columnIndex * 3 + index === 4 ? [window.centering()] : row.columnIndex * 3 + index === 5 ? fb.x -= 100 : row.columnIndex * 3 + index === 6 ? [fb.y -= 100, fb.x += 100] : row.columnIndex * 3 + index === 7 ? fb.y -= 100 : row.columnIndex * 3 + index === 8 ? [fb.y -= 100, fb.x -= 100] : row.columnIndex * 3 + index === 9 ? fb.rotation -= 30 : row.columnIndex * 3 + index === 10 ? fb.rotation += 30 : {}
                                        }
                                    }
                                }
                            }
                        }
                        ScrollView {
                            id: sv
                            height: controllerRow.height
                            width: 0.4 * menu.width
                            clip: true
                            Column {
                                anchors.right: parent.right
                                Repeater {
                                    model: ["Крива Коха", "Трикутник С.", "Дракон Х.", "ДЗ", "ДЗ2"]
                                    Button {
                                        text: modelData
                                        width: sv.width
                                        enabled: loading===100
                                        onClicked: {
                                            index === 0 ? fb.kochCurve(
                                                              ) : index === 1 ? fb.triangle() : index === 2 ? fb.dragon() : index === 3 ? fb.homeWork() : fb.homeWork2()
                                            proceed()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    //                        Text {
                    //                            id: pictureRot
                    //                            text: qsTr("Picture rotation = " + fb.rotation % 360)
                    //                    }
                }
            }
        }
    }
    Behavior on x {
        ParallelAnimation {
            PropertyAnimation {
                properties: "x"
                target: menu
                duration: 500
            }
        }
    }
    Button {
        id: bookmark
        anchors.right: menu.left
        anchors.verticalCenter: menu.verticalCenter
        width:  35//hovered ? 35:10
        text: menu.x === window.width - menu.width ? "→" : "←"
        onClicked: menu.x = menu.x === window.width ? window.width - menu.width : window.width
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
    Button {
        id: bookmark2
        anchors.right: menu.left
        anchors.top: menu.top
        width: 35
        text: "×"
        onClicked: window.close()
    }

    function proceed() {
        loading = 0
//        fb.instanceLoader.sourceComponent = undefined
        fb.axiom = axiomField.text
        fb.f = fField.text
        fb.g = gField.text
        fb.scheme = fb.axiom
        fb.iteration = iterationField.text
        fb.deltaAngle = angleField.text
        fb.scripting()
    }
}
