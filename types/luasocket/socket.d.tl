local ltn12 = require("ltn12")
local Sink = ltn12.Sink
local Source = ltn12.Source

local socket = record
   TCP = record
      -- master methods
      bind: function(string, number)
      connect: function(string, number): number, string
      listen: function(number): number, string

      -- client methods
      getpeername: function(): string, number

      TCPReceivePattern = enum
         "*l"
         "*a"
      end
      TCPReceiveError = enum
         "closed"
         "timeout"
      end
      receive: function(): string, TCPReceiveError
      receive: function(TCPReceivePattern|number): string, TCPReceiveError
      receive: function(TCPReceivePattern|number, string): string, TCPReceiveError

      send: function(string)
      send: function(string, number)
      send: function(string, number, number)

      TCPShutdownMode = enum
         "both"
         "send"
         "receive"
      end
      shutdown: function(TCPShutdownMode): number

      -- server methods
      accept: function(): TCP, string

      -- client and server methods
      TCPOption = enum
         "keepalive"
         "reuseaddr"
         "tcp-nodelay"
      end
      TCPLinger = enum
         "linger"
      end
      TCPLingerOption = record
         on: boolean
         timeout: number
      end
      setoption: function(TCPOption): number
      setoption: function(TCPLinger, TCPLingerOption): number

      -- master, client, and server methods
      close: function()

      getsockname: function(): string, number

      getstats: function(): number, number, number

      setstats: function(number, number, number): number

      TCPTimeoutMode = enum
         "b"
         "t"
      end
      settimeout: function(number, TCPTimeoutMode)
   end
   UDP = record
      close: function()

      getpeername: function(): string, number

      getsockname: function(): string, number

      UDPTimeout = enum
         "timeout"
      end
      receive: function(): string, UDPTimeout
      receive: function(number): string, UDPTimeout

      receivefrom: function(): string, string, number, UDPTimeout
      receivefrom: function(number): string, string, number, UDPTimeout

      send: function(string): number, string

      sendto: function(string, string, number): number, string

      setpeername: function(string): number, string
      setpeername: function(string, number): number, string

      setsockname: function(string, number): number, string

      UDPOptions = enum
         "dontroute"
         "broadcast"
      end
      setoption: function(UDPOptions): number, string
      setoption: function(UDPOptions, boolean): number, string

      settimeout: function(number)
   end
   tcp: function(): TCP, string

   udp: function(): UDP, string

   dns = record
      DNSResolved = record
         name: string
         alias: {string}
         ip: {string}
      end
      toip: function(): string
      tohostname: function(string): string, DNSResolved|string
      gethostname: function(string): string, DNSResolved|string
   end

   bind: function(string, number): TCP
   bind: function(string, number, number): TCP

   connect: function(string, number): TCP
   connect: function(string, number, string): TCP
   connect: function(string, number, string, number): TCP

   _DEBUG: boolean

   newtry: function(function): function

   protect: function(function): function

   -- tagged records/Table Union types would be nice here,
   -- as this should be {TCP|UDP}
   -- but I imagine this should be fine for most uses
   select: function({UDP}, {UDP}): {UDP}, {UDP}, string
   select: function({TCP}, {TCP}): {TCP}, {TCP}, string
   select: function({UDP}, {UDP}, number): {UDP}, {UDP}, string
   select: function({TCP}, {TCP}, number): {TCP}, {TCP}, string

   SinkMode = enum
      "http-chunked"
      "close-when-done"
      "keep-open"
   end

   sink: function(SinkMode, UDP): Sink<string>
   sink: function(SinkMode, TCP): Sink<string>

   skip: function(number, ...: any): any...

   sleep: function(number)

   SourceMode = enum
      "http-chunked"
      "by-length"
      "until-closed"
   end

   source: function(SourceMode, TCP): Source<string>
   source: function(SourceMode, UDP): Source<string>
   source: function(SourceMode, TCP, number): Source<string>
   source: function(SourceMode, UDP, number): Source<string>

   gettime: function(): number

   try: function(...: any): any...

   _VERSION: string
end

return socket

