local ltn12 = require("ltn12")
local Pump = ltn12.Pump
local Sink = ltn12.Sink
local Source = ltn12.Source

local smtp = record
   Message = record
      headers: {string:string}
      body: Source<string>|string|MultipartMessage
   end
   MultipartMessage = record
      {Message}
      preamble: string
      epilogue: string
   end
   message: function(Message): Source<string>

   SMTPSendFormat = record
      from: string
      rcpt: string|{string}
      source: Source<string>
      user: string
      password: string
      server: string
      port: number
      domain: string
      step: Pump<string>
      create: function
   end
   send: function(SMTPSendFormat): number, string
end

return smtp
