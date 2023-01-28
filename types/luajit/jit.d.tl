local record jit
    on:     function(function | boolean, boolean | nil)
    off:    function(function | boolean, boolean | nil)
    flush:  function(function | boolean, boolean | nil)

    --Status
    status: function(): boolean, string...
end

return jit
