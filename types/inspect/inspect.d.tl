global record InspectOptions
    depth: number
    newline: string
    indent: string
    process: function(item: any, path: {any}): any
end

local inspect: function(value: any, options: InspectOptions): string

return inspect
