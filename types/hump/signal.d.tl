local record signal

    new: function(self: signal): signal

    register: function(self: signal, s: string, f: function): function
    emit: function(self: signal, s: string, ...: any)
    remove: function(self: signal, ...:function)
    clear: function(self: signal, s: string)

    emitPattern: function(self: signal, p: string, ...: any)
    removePattern: function(self: signal, p: string, ...: function)
    clearPattern: function(self: signal, p: string)
    
end

return signal