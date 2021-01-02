local lpeg = require("lpeg")

local record re
   compile: function(s: string, defs: {string: any}): lpeg.Pattern

   find: function(subject: string, pattern: string, init: number): number, number

   gsub: function(subject: string, pattern: string, replacement: string): string

   match: function(subject: string, pattern: string): any...

   updatelocale: function(): ()
end

return re
