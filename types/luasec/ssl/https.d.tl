require("socket")
require("ssl")
require("ltn12")
local https = record
   HTTPSRequest = record
      -- HTTP options
      url: string|{string}
      sink: Sink<string>
      method: string
      headers: {string:string}
      source: Source<string>
      step: PumpStep
      -- proxy: string -- not supported
      -- redirect: boolean -- not supported
      -- create: function -- https implements its own

      -- SSL options
      mode: string
      protocol: string
      key: string
      password: string|function
      certificate: string
      certificates: {SSLCertificate}
      cafile: string
      capath: string
      verify: string|{string}
      options: string|{string}
      ciphers: string
      ciphersuites: string
      depth: number
      dhparam: function
      curve: string
      curves_list: string
      verifyext: string|{string}
      alpn: string|function|{string}
      dane: boolean
   end
   request: function(string): string, number, {string:string}, string
   request: function(string, string): string, number, {string:string}, string
   request: function(HTTPSRequest): string, number, {string:string}, string
   tcp: function(): function(): SSLConnection
end

return https
