local ltn12 = require("ltn12")
local Pump = ltn12.Pump
local Sink = ltn12.Sink

local record ftp
   get: function(string): string, string
   record FTPGetInfo
      host: string
      sink: Sink<string>
      argument: string
      path: string
      user: string
      password: string
      command: string
      port: number
      type: string
      step: Pump<string>
      create: function()
   end
   get: function(FTPGetInfo): number, string

   record FTPPutInfo
      host: string
      source: Sink<string> -- yes, this is a sink
      argument: string
      path: string
      user: string
      password: string
      command: string
      port: number
      type: string
      step: Pump<string>
      create: function()
   end
   put: function(string, string): number, string
   put: function(FTPPutInfo): number, string
end

return ftp
