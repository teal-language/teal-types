local record timer

    enum TweenType
        "linear"
        "quad"
        "cubic"
        "quart"
        "quint"
        "sine"
        "expo"
        "circ"
        "back"
        "bounce"
        "elastic"
    end

    type CallbackFunction = function()
    type DeltaCallbackFunction = function(dt: number)
    type WaitFunction = function(seconds: number)
    type Handle = table

    new: function(): timer

    script: function(func: WaitFunction)
    script: function(self: timer, func: WaitFunction)

    after: function(self: timer, delay: number, func: CallbackFunction): Handle
    after: function(delay: number, func: CallbackFunction): Handle

    every: function(delay: number, func: CallbackFunction): Handle
    every: function(self: timer, delay: number, func: CallbackFunction): Handle

    during: function(delay: number, func: DeltaCallbackFunction): Handle
    during: function(self: timer, delay: number, func: DeltaCallbackFunction): Handle

    during: function(delay: number, func: DeltaCallbackFunction, after: CallbackFunction): Handle
    during: function(self: timer, delay: number, func: DeltaCallbackFunction, after: CallbackFunction): Handle

    cancel: function(handle: Handle)
    cancel: function(self: timer, handle: Handle)

    clear: function()
    clear: function(self: timer)

    update: function(dt: number)
    update: function(self: timer, dt: number)

    tween: function(duration: number, subject: table, target: table, method: TweenType): Handle
    tween: function(self: timer, duration: number, subject: table, target: table, method: TweenType): Handle

    tween: function(duration: number, subject: table, target: table, method: TweenType, after: function, ...: any): Handle
    tween: function(self: timer, duration: number, subject: table, target: table, method: TweenType, after: function, ...: any): Handle

end

return timer