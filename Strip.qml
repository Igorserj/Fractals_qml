import QtQuick 2.15

Rectangle {
    id: rect
    property double angle: 0
    color: schemeColor
    smooth: true
    state: loading === 0 ? "Destroy" : ""
    antialiasing: true
    height: thickness
    radius: 10
    transform: Rotation {
        id: rot
        origin.x: 0
        origin.y: 0
        axis {
            x: 0
            y: 0
            z: 1
        }
        angle: rect.angle
    }
    onStateChanged: if (state === "Destroy") destroy()
}
