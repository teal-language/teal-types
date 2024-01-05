--
-- https://luarocks.org/modules/fperrad/lua-ubjson
--

local record ubjson
   _VERSION: string
   _DESCRIPTION: string
   _COPYRIGHT: string
   strict: boolean

   record Cursor
      s: string
      i: integer
      j: integer
      underflow: function(Cursor, integer)
   end

   enum Coder
      "_string"
      "_table"
      "array"
      "binary"
      "boolean"
      "float"
      "float32"
      "float64"
      "high-precision"
      "integer"
      "nil"
      "number"
      "object"
      "string"
      "table"
      "text"
   end
   coders: {Coder:function({string}, any, integer)}

   enum String
      "binary"
      "text"
      "check_utf8"
   end
   set_string: function(String)
   enum Array
      "without_hole"
      "with_hole"
      "always_as_object"
   end
   set_array: function(Array)
   enum Float
      "float32"
      "float64"
      "high-precision"
   end
   set_float: function(Float)

   encode: function(data: any): string
   encode_name: function(str: string): string
   decode_cursor: function(c: Cursor): any
   decode: function(s: string): any
   decoder: function(src: string|function(): string): function(): (boolean|integer, any)

   enum Type
      "C"
      "D"
      "F"
      "H"
      "I"
      "L"
      "N"
      "S"
      "T"
      "U"
      "Z"
      "["
      "d"
      "i"
      "l"
      "{"
   end
   open_array: function(count: integer, type_: Type): string
   open_object: function(count: integer, type_: Type): string
   close_array: function(): string
   close_object: function(): string
   no_op: function(): string
end

return ubjson
