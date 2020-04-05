local json = record
    -- Returns a string representing value encoded in JSON.
    encode: function(value: any): string

    -- Returns a value representing the decoded JSON string.
    decode: function(str: string): any
end

return json
