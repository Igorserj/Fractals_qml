WorkerScript.onMessage = function (message) {
    message.scheme += '+-'
    const regF = /F/g
    const regG = /G/g
    const regX = /X/g
    const regY = /Y/g
    for (var i = 0; i < message.iteration - 1; i++) {
        message.scheme = message.scheme.replace(regF, "X").replace(regG, "Y")
        message.scheme = message.scheme.replace(regX,
                                                message.f).replace(regY,
                                                                   message.g)
    }

    //    var schemeArray = message.scheme.split('')
    var schemeArray = message.scheme
    var deltaAngle = message.deltaAngle
    var xArr = []
    var yArr = []
    var angleArr = []
    for (i = 0; i < schemeArray.length; i++) {
        angleArr.push(0)
    }

    var widthArr = []
    var length = message.length

    for (i = 0; i < schemeArray.length; i++) {
        xArr.push(i === 0 ? 0 : xArr[i - 1] + Math.cos(
                                angleArr[i - 1] * (Math.PI / 180)) * widthArr[i - 1])

        yArr.push(i === 0 ? 0 : yArr[i - 1] + Math.sin(
                                (angleArr[i - 1]) * (Math.PI / 180)) * widthArr[i - 1])
        angleArr[i] = i === 0 ? schemeArray[(i + schemeArray.length) % schemeArray.length]
                                === "+" ? angleArr[i] + deltaAngle : schemeArray[(i + schemeArray.length) % schemeArray.length] === "-" ? angleArr[i] - deltaAngle : angleArr[i] : schemeArray[(i + schemeArray.length) % schemeArray.length] === "+" ? angleArr[i - 1] + deltaAngle : schemeArray[(i + schemeArray.length) % schemeArray.length] === "-" ? angleArr[i - 1] - deltaAngle : angleArr[i - 1]
        widthArr.push(
                    (schemeArray[(i + schemeArray.length) % schemeArray.length] === "F"
                     || schemeArray[(i + schemeArray.length)
                                    % schemeArray.length] === "G") ? length : 0)
    }
    var rotAngle = []
    for (i = 0; i < schemeArray.length; i++) {
        rotAngle.push(
                    i === 0 ? schemeArray[(i + schemeArray.length) % schemeArray.length]
                              === "+" ? angleArr[i] + deltaAngle : schemeArray[(i + schemeArray.length) % schemeArray.length] === "-" ? angleArr[i] - deltaAngle : angleArr[i] : schemeArray[(i + schemeArray.length) % schemeArray.length] === "+" ? angleArr[i - 1] + deltaAngle : schemeArray[(i + schemeArray.length) % schemeArray.length] === "-" ? angleArr[i - 1] - deltaAngle : angleArr[i - 1])
    }
    WorkerScript.sendMessage({
                                 "xArr": xArr,
                                 "yArr": yArr,
                                 "angleArr": angleArr,
                                 "widthArr": widthArr,
                                 "rotAngle": rotAngle,
                                 "schemeArray": schemeArray
                             })
}
