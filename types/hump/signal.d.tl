local record signal

    new: function(self: signal): signal

    register: function(s: string, f: function): function
    register: function(self: signal, s: string, f: function): function
    
    emit: function(s: string, ...: any)
    emit: function(self: signal, s: string, ...: any)

    remove: function(...: function)
    remove: function(self: signal, ...: function)
    
    clear: function(s: string)
    clear: function(self: signal, s: string)

    emitPattern: function(p: string, ...: any)
    emitPattern: function(self: signal, p: string, ...: any)

    removePattern: function(p: string, ...: function)
    removePattern: function(self: signal, p: string, ...: function)

    clearPattern: function(p: string)
    clearPattern: function(self: signal, p: string)
    
end

return signal