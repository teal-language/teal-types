
--[[
- local type json = {string:json}
]]

local record dkjson
   interface InputJsonUserdata is userdata
      where ((getmetatable(self) as table) or {}).__tojson
   end

   type InputJsonValue = string | number | boolean | InputJsonUserdata
      | table  -- can always be valid with getmetatable(value).__tojson defined

   type OutputJsonValue = string | number | boolean
      | {string|integer : OutputJsonValue}

   record JsonState
      indent: boolean
      keyorder: {string}
      level: number
      buffer: {string}
      bufferlen: number
      tables: {table:boolean}
      exception: function(reason: string, value: InputJsonValue, state: JsonState, defaultmessage: string): string, string
   end
   encode: function(value: InputJsonValue, state?: JsonState): string

   decode: function(str: string, pos?: number, nullval?: any, objectmeta?: table, arraymeta?: table): OutputJsonValue, number, string

   null: table

   version: string

   quotestring: function(value: string): string

   addnewline: function(state: JsonState)

   encodeexception: function(reason: string, value: InputJsonValue, state: JsonState, defaultmessage: string): string, string

   use_lpeg: function(): dkjson
end

return dkjson
