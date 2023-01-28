
local record libffi
    type CData = integer | number | string | { string | integer : CData } | nil
    type CType = string | CData
    type CFunction = function(...: any): CData
    type CNamespace = { string : CFunction | CData }

    load:       function(string): { string : CFunction | CData }
    load:       function<T>(string): T
    cdef:       function(string)
    new:        function(CType, integer | nil, ...: any): CData
    typeof:     function(CType, ...: any): CType
    cast:       function(CType, ...: any): CType
    metatype:   function(CType, metatable): CType
    gc:         function(CData, function(CData)): CData
    sizeof:     function(CType, integer | nil): integer | nil
    alignof:    function(CType): integer
    offsetof:   function(CType, string): integer, integer | nil, integer | nil
    istype:     function(CType, any): boolean
    errno:      function(integer | nil): integer
    string:     function(CData, integer | nil): string
    copy:       function(CData, CData, integer)
    copy:       function(CData, string)
    fill:       function(CData, integer, CData)
    abi:        function(string): boolean
    set:        function(function)

    C: CNamespace
end

return libffi
