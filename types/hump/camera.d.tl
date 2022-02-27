local record camera

    type DrawFunction = function()
    type SmoothingFunction = function(x: number, y: number, ...: any): number, number

    record smooth
        none: function(): SmoothingFunction
        linear: function(speed: number): SmoothingFunction
        damped: function(stiffness: number): SmoothingFunction
    end

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

    lockX: function(self: camera, x: number, smoother: SmoothingFunction, ...: any)
    lockY: function(self: camera, y: number, smoother: SmoothingFunction, ...: any)
    lockPosition: function(self: camera, x: number, y: number, smoother: SmoothingFunction, ...: any)
    lockWindow: function(self: camera, x: number, y: number, x_min: number, x_max: number, y_min: number, y_max: number, smoother: SmoothingFunction, ...: any)

    -- module is callable as a function to create a new camera
    metamethod __call: function(self: camera, x: number, y: number, zoom: number, rot: number): camera

    smoother: SmoothingFunction
    scale: number
    x: number
    y: number

end

return camera