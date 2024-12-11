local record lester
   quiet: boolean
   color: boolean
   show_traceback: boolean
   show_error: boolean
   stop_on_fail: boolean
   utf8term: boolean
   filter: string
   seconds: number
   colors: {string:string}

   describe: function(name: string, func: function())
   it: function(name: string, func: function(), enabled?: boolean)
   before: function(func: function())
   after: function(func: function())
   report: function(): boolean
   exit: function()

   record expect
      tohumanstring: function(v: any): string
      fail: function(func: function(), expected: any)
      not_fail: function(func: function())
      exist: function(v: any)
      not_exist: function(v: any)
      truthy: function(v: any)
      falsy: function(v: any)
      strict_eq: function(t1: any, t2: any, name: string): boolean, string
      equal: function(v1: any, v2: any)
      not_equal: function(v1: any, v2: any)
   end
end

return lester
