local record jsonb
   type JsonValue = string | {string|integer:JsonValue} | number | boolean | nil

   record ConversionOptions
      map: function(val: JsonValue): JsonValue
      null: any
      empty_object: boolean
      array_thresh: integer
      array_frac: integer
   end

   record JsonbDatum
      userdata

      -- If the returned JsonValue is a table, its metatable will indicate
      -- whether it corresponds to a json array or object:
      metamethod __call: function(JsonbDatum, options: ConversionOptions): JsonValue

      typeinfo: JsonbTypeInfo
   end

   record JsonbTypeInfo
      userdata

      metamethod __call: function(JsonbTypeInfo, json: string | {string|integer:any}): JsonbDatum

      fromstring: function(JsonbTypeInfo, string): JsonbDatum
      frombinary: function(JsonbTypeInfo, string): JsonbDatum
      name: function(JsonbTypeInfo, typmod: string): string
   end

   is_object: function(table): boolean
   is_array: function(table): boolean
   set_as_array: function(table): table
   set_as_object: function(table): table
   set_as_unknown: function(table): table

   -- In addition the following functions are provided from version 2.0.8 on:
   -- note: iterators hold their state in upvalues:
   pairs: function(val: JsonbDatum): (function(): string|integer, JsonbDatum, integer)
   ipairs: function(val: JsonbDatum): (function(): integer, JsonbDatum)
   type: function(val: JsonbDatum)
   type: function(val: JsonbDatum | JsonValue, lax: boolean)
end

local jval: jsonb.JsonbDatum
print((jval{} as table).pelota)

return jsonb
