local ffi = require("ffi")

local record StringBuffer
    record SerialisationOptions
        record IStringable
            metamethod __tostring: function(IStringable): string
        end

        dict:       {string}
        metatable:  {metatable<IStringable>}
    end

    type Data = string | number | SerialisationOptions.IStringable

    new:        function(integer | nil, SerialisationOptions | nil): StringBuffer
    put:        function(StringBuffer, Data, ...: Data): StringBuffer
    putf:       function(StringBuffer, string, ...: Data): StringBuffer
    putcdata:   function(StringBuffer, ffi.CData, integer): StringBuffer
    set:        function(StringBuffer, Data)
    set:        function(StringBuffer, ffi.CData, integer)
    reset:      function(StringBuffer): StringBuffer
    free:       function(StringBuffer)
    reserve:    function(StringBuffer, integer): ffi.CData, integer
    commit:     function(StringBuffer, integer): StringBuffer
    skip:       function(StringBuffer, integer): StringBuffer
    get:        function(StringBuffer, integer | nil, ...: integer): string...
    tostring:   function(StringBuffer): string

    ref:        function(StringBuffer): ffi.CData
    encode:     function(StringBuffer, Data): StringBuffer
    decode:     function(StringBuffer): Data | nil

    encode:     function(Data): string
    decode:     function(string): Data | nil

    metamethod __tostring: function(StringBuffer): string
    metamethod __call: function(StringBuffer): string
end

return StringBuffer
