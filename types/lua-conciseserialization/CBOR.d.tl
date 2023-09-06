--
-- https://luarocks.org/modules/fperrad/lua-conciseserialization
--

local record CBOR
   _VERSION: string
   _DESCRIPTION: string
   _COPYRIGHT: string
   full64bits: boolean
   long_double: boolean
   small_lua: boolean
   strict: boolean
   sentinel: any

   record Cursor
      s: string
      i: integer
      j: integer
      underflow: function(Cursor, integer)
   end

   enum Coder
      "_table"
      "array"
      "boolean"
      "byte_string"
      "double"
      "float"
      "half"
      "integer"
      "map"
      "nil"
      "null"
      "number"
      "simple"
      "single"
      "string"
      "table"
      "tag"
      "text_string"
      "undef"
      "userdata"
   end
   coders: {Coder:function({string}, any, integer)}

   BREAK: string
   OPEN_ARRAY: string
   OPEN_BYTE_STRING: string
   OPEN_MAP: string
   OPEN_TEXT_STRING: string
   MAGIC: string

   ARRAY: function(integer): string
   BYTE_STRING: function(integer): string
   MAP: function(integer): string
   SIMPLE: function(integer): string
   TAG: function(integer): string
   TEXT_STRING: function(integer): string

   enum String
      "byte_string"
      "text_string"
      "check_utf8"
   end
   set_string: function(String)
   enum Array
      "without_hole"
      "with_hole"
      "always_as_map"
   end
   set_array: function(Array)
   enum Nil
      "null"
      "undef"
   end
   set_nil: function(Nil)
   enum Float
      "half"
      "single"
      "double"
   end
   set_float: function(Float)

   encode: function(data: any): string
   decode_cursor: function(c: Cursor): any
   register_simple: function(n: integer, val: any)
   register_tag: function(tag: integer, builder: function(any): any)
   decode: function(s: string): any
   decoder: function(src: string|function(): string): function(): (boolean|integer, any)
end

return CBOR
