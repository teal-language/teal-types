local record elog
   enum Severity
      "debug"
      "log"
      "info"
      "notice"
      "warning"
      "error"
   end

   record ELogInfo
      sqlstate: string
      message: string
      detail: string
      table: string
      column: string
      datatype: string
      constraint: string
      schema: string
   end

   elog: function(Severity, message: string)
   elog: function(Severity, sqlstate: string, message: string)
   elog: function(Severity, sqlstate: string, message: string, detail: string)
   elog: function(Severity, sqlstate: string, message: string, detail: string, hint: string)
   elog: function(Severity, ELogInfo)

   debug: function(message: string)
   debug: function(sqlstate: string, message: string)
   debug: function(sqlstate: string, message: string, detail: string)
   debug: function(sqlstate: string, message: string, detail: string, hint: string)
   debug: function(ELogInfo)

   log: function(message: string)
   log: function(sqlstate: string, message: string)
   log: function(sqlstate: string, message: string, detail: string)
   log: function(sqlstate: string, message: string, detail: string, hint: string)
   log: function(ELogInfo)

   info: function(message: string)
   info: function(sqlstate: string, message: string)
   info: function(sqlstate: string, message: string, detail: string)
   info: function(sqlstate: string, message: string, detail: string, hint: string)
   info: function(ELogInfo)

   notice: function(message: string)
   notice: function(sqlstate: string, message: string)
   notice: function(sqlstate: string, message: string, detail: string)
   notice: function(sqlstate: string, message: string, detail: string, hint: string)
   notice: function(ELogInfo)

   warning: function(message: string)
   warning: function(sqlstate: string, message: string)
   warning: function(sqlstate: string, message: string, detail: string)
   warning: function(sqlstate: string, message: string, detail: string, hint: string)
   warning: function(ELogInfo)

   error: function(message: string)
   error: function(sqlstate: string, message: string)
   error: function(sqlstate: string, message: string, detail: string)
   error: function(sqlstate: string, message: string, detail: string, hint: string)
   error: function(ELogInfo)
end

return elog
