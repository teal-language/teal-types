local ltn12 = require("ltn12")
local Pump = ltn12.Pump
local Sink = ltn12.Sink
local Source = ltn12.Source

local record smtp
   record Message
      headers: {string:string}
      body: Source<string>|string|MultipartMessage
   end
   record MultipartMessage
      {Message}
      preamble: string
      epilogue: string
   end
   message: function(Message): Source<string>

   record SMTPSendFormat
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
