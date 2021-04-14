local ltn12 = require("ltn12")
local type Pump = ltn12.Pump
local type Sink = ltn12.Sink

local record ftp
   get: function(string): string, string
   record FTPGetInfo
      host: string
      sink: Sink
      argument: string
      path: string
      user: string
      password: string
      command: string
      port: integer
      type: string
      step: Pump
      create: function()
   end
   get: function(FTPGetInfo): integer, string

   record FTPPutInfo
      host: string
      source: Sink -- yes, this is a sink
      argument: string
      path: string
      user: string
      password: string
      command: string
      port: integer
      type: string
      step: Pump
      create: function()
   end
   put: function(string, string): integer, string
   put: function(FTPPutInfo): integer, string
end

return ftp
