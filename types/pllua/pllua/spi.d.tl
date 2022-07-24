require 'pllua.pgtype'
local elog = require 'pllua.elog'

local record spi
   -- Row is a datum (userdata) which can be indexed by name or position, giving values
   -- that can have any type (depending on the query) or even be datums themselves
   type Row = any

   execute: function(query: string, ...: any): {Row} | integer
   execute_count: function(query: string, maxrows: integer, ...: any): {Row} | integer

   record PrepareOptions
      scroll: boolean
      no_scroll: boolean
      hold: boolean
      fast_start: boolean
      custom_plan: boolean
      generic_plan: boolean
      fetch_count: integer
   end

   record Statement
      metamethod __call: function(Statement, ...: any): {Row} | integer
   
      execute: function(Statement, ...: any): {Row} | integer
      execute_count: function(Statement, maxrows: integer, ...: any): {Row} | integer
      getcursor: function(Statement, ...: any): Cursor
      rows: function(Statement, ...: any): (function(): Row)  -- row iterator

      numargs: function(Statement): integer
      argtype: function(Statement, argnum: integer): TypeInfo
   end

   prepare: function(query: string, argtypes: {string | TypeInfo}): Statement
   prepare: function(query: string, argtypes: {string | TypeInfo}, options: PrepareOptions): Statement

   rows: function(query: string, ...: any): (function(): Row)  -- row iterator

   record Cursor
      enum Direction
         -- fetch N rows forward:
         "forward"
         "next"
         -- fetch N rows backward:
         "backward"
         "prior"
         -- fetch row at absolute position n:
         "absolute"
         -- fetch row at relative position n:
         "relative"
      end

      open: function(Cursor, Statement, ...: any): Cursor
      open: function(Cursor, query: string, ...: any): Cursor

      isopen: function(Cursor): boolean
      close: function(Cursor)

      isowned: function(Cursor): boolean
      own: function(Cursor): Cursor
      disown: function(Cursor): Cursor

      name: function(Cursor): string | nil

      fetch: function(Cursor): {Row}  -- a list with up to one fetched rows
      fetch: function(Cursor, n: integer): {Row}  -- up to n rows forward
      fetch: function(Cursor, n: integer, dir: Direction)

      move: function(Cursor)
      move: function(Cursor, n: integer)
      move: function(Cursor, n: integer, dir: Direction)
   end

   findcursor: function(name: string): Cursor|nil

   newcursor: function(): Cursor
   newcursor: function(name: string): Cursor

   is_atomic: function(): boolean

   -- not defined before postgresql 11:
   commit: function()
   rollback: function()

   -- These functions from pllua.elog are accessible via spi.* for convenience.
   elog: function(elog.Severity, message: string)
   elog: function(elog.Severity, sqlstate: string, message: string)
   elog: function(elog.Severity, sqlstate: string, message: string, detail: string)
   elog: function(elog.Severity, sqlstate: string, message: string, detail: string, hint: string)
   elog: function(elog.Severity, elog.ELogInfo)

   debug: function(message: string)
   debug: function(sqlstate: string, message: string)
   debug: function(sqlstate: string, message: string, detail: string)
   debug: function(sqlstate: string, message: string, detail: string, hint: string)
   debug: function(elog.ELogInfo)

   log: function(message: string)
   log: function(sqlstate: string, message: string)
   log: function(sqlstate: string, message: string, detail: string)
   log: function(sqlstate: string, message: string, detail: string, hint: string)
   log: function(elog.ELogInfo)

   info: function(message: string)
   info: function(sqlstate: string, message: string)
   info: function(sqlstate: string, message: string, detail: string)
   info: function(sqlstate: string, message: string, detail: string, hint: string)
   info: function(elog.ELogInfo)

   notice: function(message: string)
   notice: function(sqlstate: string, message: string)
   notice: function(sqlstate: string, message: string, detail: string)
   notice: function(sqlstate: string, message: string, detail: string, hint: string)
   notice: function(elog.ELogInfo)

   warning: function(message: string)
   warning: function(sqlstate: string, message: string)
   warning: function(sqlstate: string, message: string, detail: string)
   warning: function(sqlstate: string, message: string, detail: string, hint: string)
   warning: function(elog.ELogInfo)

   error: function(message: string)
   error: function(sqlstate: string, message: string)
   error: function(sqlstate: string, message: string, detail: string)
   error: function(sqlstate: string, message: string, detail: string, hint: string)
   error: function(elog.ELogInfo)
end

return spi
