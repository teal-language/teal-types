local record ansicolors
   noReset: function(str: string): string
   metamethod __call: function(_: ansicolors, str: string): string
end

return ansicolors
