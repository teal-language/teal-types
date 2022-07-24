local type Datum = any

--   TypeInfo can't be exported here since in tl a module cannot return a Map
-- with records inside nor a maprecord (map|record).  This is why it's global.
global record TypeInfo
   userdata

   -- Construct a new Datum object by copying from the specified value, which must already be of a compatible type
   metamethod __call: function(TypeInfo, datum: Datum): Datum
   -- Construct a new Datum object of the specified type from the arguments given. The nature of the arguments varies according to the category of type being constructed.
   -- More info in: https://pllua.github.io/pllua/#S2.6
   --   Consider casting Datum to the correct datum type such as time.DatetimeDatum or numeric.NumericDatum,
   -- or even {string|integer:Datum} for rows/arrays, but be careful when using pairs/ipairs:
   metamethod __call: function(TypeInfo, ...: any): Datum
   -- If cyclic requires were supported we could have:
   --metamethod __call: function(TypeInfo, time.CalendarTable): time.DatetimeDatum

   -- Construct a new Datum object given its standard text representation in str. For some types the distinction between typeinfo:fromstring(str) and typeinfo(str) is significant.
   fromstring: function(TypeInfo, string): Datum
   -- Construct a new Datum object given its wire-protocol binary representation in str. This is less useful than it might seem because for many data types, the interpretation of the binary representation is dependent on the client_encoding setting.
   frombinary: function(TypeInfo, string): Datum
   --Returns the name of the type as SQL syntax (same as the format_type function in SQL, or ::regtype output)
   name: function(TypeInfo, typmod: string): string

   -- For array or range types, returns the typeinfo of the element type
   element: function(TypeInfo): TypeInfo
   -- For row types, returns the typeinfo of the named column 
   element: function(TypeInfo, column_name: string): TypeInfo
end

local type SQLTypeName = string
local type datumtofunction = function(value: Datum|any, argno: integer): TypeInfo

-- pgtype contains as well a special entry called "array" whose type is {SQLTypeName: TypeInfo}.
-- you will have to cast pgtype to use it, or you can use pgtype['elemtype[]'] instead.
--   There's also another special entry "jsonb" which returns a JsonbTypeInfo
local pgtype: {SQLTypeName: TypeInfo} | datumtofunction

return pgtype
