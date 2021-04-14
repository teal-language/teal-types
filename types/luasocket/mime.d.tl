local ltn12 = require("ltn12")
local type Filter = ltn12.Filter

local record mime
   normalize: function(): Filter
   normalize: function(string): Filter

   enum Encoding
      "base64"
      "quoted-printable"
   end
   enum Mode
      "text"
      "binary"
   end

   decode: function(Encoding): Filter
   encode: function(Encoding, Mode): Filter

   stuff: function(): Filter

   wrap: function(string, integer): Filter
   wrap: function(Encoding): Filter

   b64: function(string, string): string, string

   dot: function(integer, string): string, integer

   eol: function(integer, string, string): string, integer

   qp: function(string, string, string): string, string

   qpwrp: function(integer, string, integer): string, integer

   unb64: function(string, string): string, string

   unqp: function(string, string): string, string

   wrp: function(integer, string, integer): string, integer
end

return mime
