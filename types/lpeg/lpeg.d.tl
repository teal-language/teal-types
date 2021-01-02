
local record lpeg

   -- FIXME: actually {string} & {string:Pattern}
   type Grammar = {(string|number): (string|Pattern)}

   record Pattern
      userdata

      metamethod __len: function(Pattern): Pattern
      metamethod __unm: function(Pattern): Pattern
      metamethod __add: function(Pattern): Pattern
      metamethod __sub: function(Pattern): Pattern
      metamethod __mul: function(Pattern): Pattern
      metamethod __pow: function(Pattern): Pattern
      metamethod __div: function(Pattern, string): Pattern
      metamethod __div: function(Pattern, number): Pattern
      metamethod __div: function<A, B>(Pattern, {A: B}): Pattern
      metamethod __div: function(Pattern, function(...: any): any...): Pattern
   end

   record Locale
      alnum: Pattern
      alpha: Pattern
      cntrl: Pattern
      digit: Pattern
      graph: Pattern
      lower: Pattern
      print: Pattern
      punct: Pattern
      space: Pattern
      upper: Pattern
      xdigit: Pattern
   end

   match: function(pattern: Pattern, subject: string, init: number): number
   match: function(pattern: Pattern, subject: string, init: number): any...

   type: function(patt: Pattern): string

   version: function(): string

   setmaxstack: function(max: number)

   P: function(p: Pattern | string | number | boolean | Grammar | function): Pattern
   B: function(patt: Pattern): Pattern
   R: function(...: string): Pattern
   S: function(string): Pattern
   V: function(string): Pattern

   locale: function(Locale): Locale

   C: function(patt: Pattern): Pattern
   Carg: function(n: number): Pattern
   Cb: function(name: string): Pattern
   Cc: function(...: any): Pattern
   Cf: function(patt: Pattern, func: function(any, any): any): Pattern
   Cg: function(patt: Pattern, name: string): Pattern
   Cp: function(): Pattern
   Cs: function(patt: Pattern): Pattern
   Ct: function(patt: Pattern): Pattern
   Cmt: function(patt: Pattern, func: function(string, number, ...: any): (number|boolean)): Pattern
end

return lpeg
