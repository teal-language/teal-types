local record camera

    type DrawFunction = function()
    type SmoothingFunction = function(x: number, y: number, s: number): number, number

    new: function(x: number, y: number, zoom: number, rot: number): camera

    move: function(self: camera, dx: number, dy: number): camera
    lookAt: function(self: camera, x: number, y: number): camera
    position: function(self: camera): number, number

    rotate: function(self: camera, angle: number): camera
    rotateTo: function(self: camera, angle: number): camera

    zoom: function(self: camera, mul: number): camera
    zoomTo: function(self: camera, zoom: number): camera

    attach: function(self: camera)
    detach: function(self: camera)

    draw: function(self: camera, func: DrawFunction)
    worldCoords: function(self: camera, x: number, y: number): number, number
    cameraCoords: function(self: camera, x: number, y: number): number, number
    mousePosition: function(self: camera): number, number

    -- no extra args to lockX, lockY atm, TODO
    lockX: function(self: camera, x: number, smoother: SmoothingFunction)
    lockY: function(self: camera, y: number, smoother: SmoothingFunction)
    lockPosition: function(self: camera, x: number, y: number, smoother: SmoothingFunction)
    lockWindow: function(self: camera, x: number, y: number, x_min: number, x_max: number, y_min: number, y_max: number, smoother: SmoothingFunction)

    smoother: SmoothingFunction
    scale: number
    x: number
    y: number

end

return camera