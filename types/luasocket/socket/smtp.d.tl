local ltn12 = require("ltn12")
local type Pump = ltn12.Pump
local type Source = ltn12.Source

local record smtp
   record Message
      headers: {string:string}
      body: Source | string | MultipartMessage
   end
   record MultipartMessage
      {Message}
      preamble: string
      epilogue: string
   end
   message: function(Message): Source

   record SMTPSendFormat
      from: string
      rcpt: string | {string}
      source: Source
      user: string
      password: string
      server: string
      port: integer
      domain: string
      step: Pump
      create: function
   end
   send: function(SMTPSendFormat): integer, string
end

return smtp
