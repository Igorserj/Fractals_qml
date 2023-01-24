import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: window
    property bool exit: false
    property int loading: 0// fb.instanceLoader.progress * 100 // (objectsQ-1) / fb.schemeArray.length * 100 < 0 ? 0 : (objectsQ-1) / fb.schemeArray.length * 100
    property string bgColor: "black"
    width: 1280
    height: 720
    visible: true
    title: "Fractals " + loading + "%"
    onClosing: {
        close.accepted = exit
        exitDialog.visible = true
    }
    onLoadingChanged: {
        loading == 100 ? [menu.zoomSlider.value = fb.scale, centering()] : {}
    }
    function centering() {
        fb.x = window.width / 2
        fb.y = window.height / 2
    }
    function scaling(scrolling = 0, relation = "absolute") {
        if (relation === "relative") {
            return fb.scale + scrolling > 2 ? fb.scale = 2 : fb.scale + scrolling
                                              < 0 ? fb.scale = 0 : fb.scale += scrolling
        } else if (relation === "absolute") {
            fb.scale = scrolling
        }
    }

    Rectangle {
        color: bgColor
        anchors.fill: parent
        focus: true
        Keys.onPressed: event => {
                            if (event.key === Qt.Key_Escape) {
                                exitDialog.visible = !exitDialog.visible
                            }
                            event.accepted = true
                        }
        //        GestureEvent {

        //        }
        Text {
            id: attention
            text: qsTr("Зменшіть кількість ітерацій!")
            color: "red"
            font.pointSize: 12
            opacity: 0
            anchors.horizontalCenter: parent.horizontalCenter
            Behavior on opacity {
                SequentialAnimation {
                    OpacityAnimator {
                        target: attention
                        duration: 200
                        from: 0
                        to: 1
                    }
                    ScriptAction {
                        script: opacityAnimation2.running = true
                    }
                }
            }
        }
        SequentialAnimation {
            id: opacityAnimation2
            PauseAnimation {
                duration: 2000
            }
            OpacityAnimator {
                target: attention
                duration: 200
                from: 1
                to: 0
            }
        }

        MouseArea {
            anchors.fill: parent
            drag.target: fb
            onWheel: {
                if (wheel.modifiers & Qt.ControlModifier) {
                    scaling(wheel.angleDelta.y / 2880, "relative")
                }
            }
        }

        PinchHandler {
            target: fb
        }
        FractalBuilder {
            id: fb
            Behavior on x {
                SequentialAnimation {
                    PropertyAnimation {
                        properties: "x"
                        target: fb
                        duration: 300
                    }
                }
            }
            Behavior on y {
                SequentialAnimation {
                    PropertyAnimation {
                        properties: "y"
                        target: fb
                        duration: 300
                    }
                }
            }
            Behavior on rotation {
                SequentialAnimation {
                    PropertyAnimation {
                        properties: "rotation"
                        target: fb
                        duration: 200
                    }
                }
            }
            Behavior on scale {
                SequentialAnimation {
                    PropertyAnimation {
                        properties: "scale"
                        target: fb
                        duration: 50
                    }
                }
            }
        }
        Menu3 {
            id: menu
        }
        Menu2 {
            id: menu2
        }
        //        }
        //        }
    }

    Dialog {
        id: exitDialog
        title: "Close application?"
        visible: false
        anchors.centerIn: parent
        standardButtons: Dialog.Yes | Dialog.No
        onAccepted: {
            window.exit = true
            window.close()
        }
        onRejected: exitDialog.visible = false
    }

    FontLoader {
        id: customFont
        source: "fonts/MarckScript-Regular.ttf"
    }
    Popup {
        visible: loading < 100
        x: (parent.width-width)/2
        y: parent.height-height
        enabled: visible
        ProgressBar {
            from: 0
            to: 100
            value: loading
        }
    }
}
