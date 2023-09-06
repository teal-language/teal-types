--
-- https://luarocks.org/modules/fperrad/lua-messagepack
--

local record MessagePack
   _VERSION: string
   _DESCRIPTION: string
   _COPYRIGHT: string
   full64bits: boolean
   long_double: boolean
   small_lua: boolean
   sentinel: any

   record Cursor
      s: string
      i: integer
      j: integer
      underflow: function(Cursor, integer)
   end

   enum Packer
      "_string"
      "_table"
      "array"
      "binary"
      "boolean"
      "double"
      "ext"
      "fixext1"
      "fixext2"
      "fixext4"
      "fixext8"
      "fixext16"
      "float"
      "integer"
      "map"
      "nil"
      "number"
      "signed"
      "string"
      "string_compat"
      "table"
      "unsigned"
      "userdata"
   end
   packers: {Packer:function({string}, any, integer|string)}

   enum String
      "string_compat"
      "string"
      "binary"
   end
   set_string: function(String)
   enum Array
      "without_hole"
      "with_hole"
      "always_as_map"
   end
   set_array: function(Array)
   enum Number
      "float"
      "double"
   end
   set_number: function(Number)

   pack: function(data: any): string
   build_ext: function(tag: integer, data: string): any
   unpack_cursor: function(c: Cursor): any
   unpack: function(s: string): any
   unpacker: function(src: string|function(): string): function(): (boolean|integer, any)
end

return MessagePack
