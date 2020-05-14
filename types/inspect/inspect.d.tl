global InspectOptions = record
    depth: number
    newline: string
    indent: string
    -- process: function()
end

local inspect: function(value: any, options: InspectOptions): string

return inspect
