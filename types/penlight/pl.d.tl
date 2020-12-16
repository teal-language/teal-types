local record pl
    record app
        script_name: function(): string
        require_here: function(string): any
        appfile: function(string): string
        platform: function(): string
        lua: function(): string, string
        parse_args: function({string}, table, table)
    end
end

return pl
