
--[[
- local type json = {string:json}
]]

local record dkjson
   record JsonState
      indent: boolean
      keyorder: {string}
      level: number
      buffer: {string}
      bufferlen: number
      tables: {table:boolean}
      exception: function(reason: string, value: any, state: JsonState, defaultmessage: string): string, string
   end
   encode: function(value: {string:any}, state?: JsonState): string

   decode: function(str: string, pos?: number, nullval?: any, objectmeta?: table, arraymeta?: table): {string:any}, number, string

   null: table

   version: string

   quotestring: function(value: string): string

   addnewline: function(state: JsonState)

   encodeexception: function(reason: string, value: any, state: JsonState, defaultmessage: string): string, string

   use_lpeg: function(): dkjson
end

return dkjson
