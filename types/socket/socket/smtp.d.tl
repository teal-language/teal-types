require("ltn12")
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
   send: function(SMPTSendFormat): number, string
end

return smtp
