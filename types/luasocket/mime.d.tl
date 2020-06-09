local ltn12 = require("ltn12")
local Filter = ltn12.Filter

local mime = record
   normalize: function(): Filter<string>
   normalize: function(string): Filter<string>

   Encoding = enum
      "base64"
      "quoted-printable"
   end
   Mode = enum
      "text"
      "binary"
   end

   decode: function(Encoding): Filter<string>
   encode: function(Encoding): Filter<string>
   encode: function(Encoding, Mode): Filter<string>

   stuff: function(): Filter<string>

   wrap: function(string, number): Filter<string>
   wrap: function(Encoding): Filter<string>

   b64: function(string): string, nil
   b64: function(string, string): string, string

   dot: function(number): string, number
   dot: function(number, string): string, number

   eol: function(number): string, number
   eol: function(number, string): string, number
   eol: function(number, string, string): string, number

   qp: function(string): string, string
   qp: function(string, string): string, string
   qp: function(string, string, string): string, string

   qpwrp: function(number): string, number
   qpwrp: function(number, string): string, number
   qpwrp: function(number, string, number): string, number

   unb64: function(string): string, string
   unb64: function(string, string): string, string

   unqp: function(string): string, string
   unqp: function(string, string): string, string

   wrp: function(number): string, number
   wrp: function(number, string): string, number
   wrp: function(number, string, number): string, number
end

return mime
