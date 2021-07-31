local record inspect
    record InspectOptions
        depth: number
        newline: string
        indent: string
        process: function(item: any, path: {any}): any
    end

    metamethod __call: function(self: inspect, value: any, options: InspectOptions): string
end

return inspect
