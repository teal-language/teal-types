require 'pllua.pgtype'

-- NumericDatum has metamethods for mathematical operations, but care must be
-- taken if == is used, since Lua compares their types before calling __eq, so
-- the comparison of userdata and number values will always be false.
local record numeric
   record NumericDatum
      userdata

      metamethod __tostring: function(NumericDatum): string
      metamethod __add: function(NumericDatum|number, NumericDatum|number): NumericDatum
      metamethod __div: function(NumericDatum|number, NumericDatum|number): NumericDatum
      metamethod __eq: function(NumericDatum|number, NumericDatum|number): NumericDatum
      metamethod __idiv: function(NumericDatum|number, NumericDatum|number): NumericDatum
      metamethod __le: function(NumericDatum|number, NumericDatum|number): NumericDatum
      metamethod __lt: function(NumericDatum|number, NumericDatum|number): NumericDatum
      metamethod __mod: function(NumericDatum|number, NumericDatum|number): NumericDatum
      metamethod __mul: function(NumericDatum|number, NumericDatum|number): NumericDatum
      metamethod __pow: function(NumericDatum|number, NumericDatum|number): NumericDatum
      metamethod __sub: function(NumericDatum|number, NumericDatum|number): NumericDatum
      metamethod __unm: function(NumericDatum): NumericDatum

      typeinfo: TypeInfo
   end

   abs: function(number|NumericDatum): NumericDatum
   ceil: function(number|NumericDatum): NumericDatum
   equal: function(number|NumericDatum, number|NumericDatum): boolean
   exp: function(number|NumericDatum): NumericDatum
   floor: function(number|NumericDatum): NumericDatum
   isnan: function(number|NumericDatum): boolean
   sign: function(number|NumericDatum): NumericDatum  -- yes, a datum with -1, 0 or 1
   sqrt: function(number|NumericDatum): NumericDatum
   log: function(number|NumericDatum): NumericDatum
   log: function(number|NumericDatum, base: number|NumericDatum): NumericDatum
   tointeger: function(number|NumericDatum): integer|nil
   tointeger: function(number|NumericDatum): integer|nil
   tointeger: function(number|NumericDatum): integer|nil
   trunc: function(number|NumericDatum): NumericDatum
   trunc: function(number|NumericDatum, digits: integer): NumericDatum
   round: function(number|NumericDatum): NumericDatum
   round: function(number|NumericDatum, digits: integer): NumericDatum

   new: function(number|NumericDatum): NumericDatum
end

return numeric
