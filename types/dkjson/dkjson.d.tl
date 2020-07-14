
--[[
- local type json = {string:json}
]]

local dkjson = record
   JsonState = record
      indent: boolean
      keyorder: {string}
      level: number
      buffer: {string}
      bufferlen: number
      tables: {table:boolean}
      exception: function(string, string, string, string): boolean|string, string
   end
   encode: function(string): {string:any}
   encode: function(string, JsonState): {string:any}

   decode: function(string): {string:any}
   decode: function(string, number): {string:any}
   decode: function(string, number, any): {string:any}
   decode: function(string, number, any, table): {string:any}

   null: table

   version: string

   quotestring: function(string): string

   addnewline: function(JsonState)

   encodeexception: function(string, any): string
   encodeexception: function(string, any, JsonState): string
   encodeexception: function(string, any, JsonState, string): string

   use_lpeg: function(): dkjson
end

return dkjson
