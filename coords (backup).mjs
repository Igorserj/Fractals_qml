WorkerScript.onMessage = function (message) {

    var schemes = message.schemes
    var length = message.length
    var index = message.index
    var prevX = message.prevX
    var prevAngle = message.prevAngle
    var prevY = message.prevY
    var prevWidth = message.prevWidth
    var deltaAngle = message.deltaAngle
    var curAngle = message.curAngle

    console.log(prevAngle)

    //    console.log(schemes + " " + length + " " + index + " " + prevX + " " + prevAngle + " "
    //                + prevY + " " + prevWidth + " " + deltaAngle + " " + curAngle)
    var x = index === 0 ? 0 : prevX + Math.cos(
                              prevAngle * (Math.PI / 180)) * prevWidth
    var y = index === 0 ? 0 : prevY + Math.sin(
                              (prevAngle) * (Math.PI / 180)) * prevWidth
    var angle = index === 0 ? schemes[(index + schemes.length) % schemes.length] === "+" ? curAngle + deltaAngle : schemes[(index + schemes.length) % schemes.length] === "-" ? curAngle - deltaAngle : curAngle : schemes[(index + schemes.length) % schemes.length] === "+" ? prevAngle + deltaAngle : schemes[(index + schemes.length) % schemes.length] === "-" ? prevAngle - deltaAngle : prevAngle
    var width = (schemes[(index + schemes.length) % schemes.length] === "F"
                 || schemes[(index + schemes.length) % schemes.length] === "G") ? length : 0

    WorkerScript.sendMessage({
                                 "x": x,
                                 "y": y,
                                 "angle": angle,
                                 "width": width,
                                 "index": index
                             })
}
