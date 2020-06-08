require("ltn12")
local http = record
   request: function(string): string, number|string, string, string
   request: function(string, string): string, number|string, string, string
   HTTPRequest = record
      url: string
      sink: Sink<string>
      method: string
      headers: {string:string}
      source: Source<string>
      step: Pump<string>
      proxy: string
      redirect: boolean
      create: function
   end
   request: function(HTTPRequest): string, number|string, string, string

   PORT: number
   PROXY: string
   TIMEOUT: number
   USERAGENT: string
end

return http
