import QtQuick 2.15
import QtQuick.Controls 2.15

//import QtQml.Models 2.15
Item {
    id: fb
    focus: true
    property alias fbBg: fbBg
    property double deltaAngle: 0
    property string axiom: ""
    property string scheme: ""
    property var schemeArray: []
    property string f: ""
    property string g: ""
    property string schemeColor: "white"
    property int length: 70
    property int thickness: 3
    property int iteration: 1
    //    property alias instanceLoader: instanceLoader
    Component.onCompleted: scriptRun.running = true

    Rectangle {
        id: fbBg
        color: "transparent"
        border.width: 0
        border.color: "white"
        onWidthChanged: {
            fb.scale = window.width / width < window.height
                    / height ? window.width / width
                               > 1 ? 1 : window.width / width : window.height
                                     / height > 1 ? 1 : window.height / height
        }
    }

    //    QtObject {
    //        id: instantiatorSettings
    //        property var xArr: []
    //        property var yArr: []
    //        property var widthArr: []
    //        property var angleArr: []
    //    }

    //    Loader {
    //        id: instanceLoader
    //        asynchronous: true
    //    }

    //    Component {
    //        id: instance
    //        Repeater {
    //            model: schemeArray.length
    //            delegate: Strip {
    //                x: instantiatorSettings.xArr[index]
    //                y: instantiatorSettings.yArr[index]
    //                width: instantiatorSettings.widthArr[index]
    //                angle: instantiatorSettings.angleArr[index]
    //            }
    //        }
    //    }

    //    Component {
    //        id: strip
    //        Strip {
    //            x: instantiatorSettings.xArr[index]//[index]
    //            y: instantiatorSettings.yArr[index]//[index]
    //            width: instantiatorSettings.widthArr[index]//[index]
    //            angle: instantiatorSettings.angleArr[index]//[index]
    //        }
    //    }
    WorkerScript {
        id: myScript
        //        property var messageObject: messageObject
        onMessage: {
            assigning(messageObject)
        }
    }

    SequentialAnimation {
        id: scriptRun
        PauseAnimation {
            duration: 200
        }
        ScriptAction {
            script: scripting()
        }
    }

    function scripting() {
        myScript.source = "lSystem.mjs"
        var message = {
            "scheme": scheme,
            "iteration": iteration,
            "f": f,
            "g": g,
            "deltaAngle": deltaAngle,
            "length": length
        }
        myScript.sendMessage(message)
    }

    function assigning(messageObject) {
        //        var objectsQ = 1
        var incubs = []
        //        schemeArray = []
        loading = 1
        //        instantiatorSettings.xArr = messageObject.xArr
        //        instantiatorSettings.yArr = messageObject.yArr
        //        instantiatorSettings.widthArr = messageObject.widthArr
        //        instantiatorSettings.angleArr = messageObject.rotAngle
        var rectangle = Qt.createComponent("Strip.qml")
        schemeArray = messageObject.schemeArray
        //        instanceLoader.sourceComponent = instance
        //                instance.delegate = strip
        for (var index = 0; index < schemeArray.length; index++) {
            incubs.push(rectangle.incubateObject(fb, {
                                                     "x": messageObject.xArr[index],
                                                     "y": messageObject.yArr[index],
                                                     "width": messageObject.widthArr[index],
                                                     "angle": messageObject.rotAngle[index]
                                                 }))
            //            loading = (index+1)/schemeArray.length*100
        }
        console.log("x", messageObject.xArr[schemeArray.length - 1], "y",
                    messageObject.yArr[schemeArray.length - 1], "width",
                    messageObject.widthArr[schemeArray.length - 1], "angle",
                    messageObject.rotAngle[schemeArray.length - 1])
        loading = 100
    }

    function kochCurve() {
        deltaAngle = 90
        axiom = "F"
        scheme = "F+F-F-F+F"
        f = "F+F-F-F+F"
        g = ""
        iteration = 2
    }
    function triangle() {
        deltaAngle = 120
        axiom = "F-G-G"
        scheme = "F-G+F+G-F"
        f = "F-G+F+G-F"
        g = "GG"
        iteration = 2
    }
    function dragon() {
        deltaAngle = 90
        axiom = "F"
        scheme = "F+G"
        f = "F+G"
        g = "F-G"
        iteration = 3
    }
    function homeWork() {
        deltaAngle = 45
        axiom = "F"
        scheme = "F-F+++FFF---F+F"
        f = "F-F+++FFF---F+F"
        g = ""
        iteration = 2
    }
    function homeWork2() {
        deltaAngle = 90
        axiom = "F"
        scheme = "-F+F-F+FF+F+F-F-FF+F+F-F-FF-F+F-F"
        f = "-F+F-F+FF+F+F-F-FF+F+F-F-FF-F+F-F"
        g = ""
        iteration = 2
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/

