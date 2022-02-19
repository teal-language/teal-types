local record gamestate

    new: function(): gamestate

    switch: function(to: table, ...: any): any...
    current: function(): table

    push: function(to: table, ...: any): any...
    pop: function(): any...

    registerEvents: function()
    registerEvents: function({string})

    -- hardcoded love lifecycle functions here, just the very basics :I
    update: function(dt: number)
    draw: function()

end

return gamestate