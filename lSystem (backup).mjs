WorkerScript.onMessage = function (message) {
    var opacity = 0
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

    var schemeArray = message.scheme.split('') //.splice(0, 8 * 1024 - 1)
    WorkerScript.sendMessage({
                                 "opacity": opacity,
                                 "schemeArray": schemeArray
                             })
}
