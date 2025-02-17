local record lanes
   record cancel_error
      userdata
   end

   interface Lane
      is {any}

      enum Status
         "pending"
         "running"
         "waiting"
         "done"
         "error"
         "cancelled"
         "killed"
      end

      enum CancelStatus
         "done"
         "error"
         "cancelled"
         "killed"
         "timeout"
      end

      enum CancelHard
         "hard"
      end

      enum CancelSoft
         "soft"
      end

      enum CancelOther
         "count"
         "line"
         "call"
         "ret"
      end

      status: Status

      -- either returns the results of the lane function
      -- or returns nil, any, {string|debug.GetInfoTable}
      join: function(self, ? number): any...

      -- hard cancelling     mode                 timeout forcekill  killtimeout
      cancel: function(self,                              ? boolean, ? number ): boolean, CancelStatus
      cancel: function(self, CancelHard,                  ? boolean, ? number ): boolean, CancelStatus
      cancel: function(self,                      number, ? boolean, ? number ): boolean, CancelStatus
      cancel: function(self, CancelHard,          number, ? boolean, ? number ): boolean, CancelStatus

      -- soft cancelling     mode                 timeout wake
      cancel: function(self, CancelSoft,                  ? boolean           ): boolean, CancelStatus
      cancel: function(self, CancelSoft,          number, ? boolean           ): boolean, CancelStatus

      -- other cancelling    mode         hookcnt timeout forcekill  killtimeout
      cancel: function(self, CancelOther, number,         ? boolean, ? number ): boolean, CancelStatus
      cancel: function(self, CancelOther, number, number, ? boolean, ? number ): boolean, CancelStatus
   end

   interface Linda
      interface LdNull
         userdata
      end
      interface LdBatched
         userdata
      end

      type LdKey = string | number | boolean
      type LdKeyNoNum = string | boolean

      enum CancelChoice
         "read"
         "write"
         "both"
         "none"
      end

      null: LdNull
      batched: LdBatched

      -- if the key is a number, use linda:send(nil, key, ...)
      -- with linda.null, these don't error if nothing is provided in a value and instead send a single `nil`
      --                   timeout sendnil key         values
      send: function(self,                 LdKeyNoNum, any, any...): boolean | cancel_error
      send: function(self, number,         LdKey,      any, any...): boolean | cancel_error
      send: function(self, number, LdNull, LdKey,      any...):      boolean | cancel_error
      send: function(self,         LdNull, LdKey,      any...):      boolean | cancel_error

      -- if the first key is a number, use linda:receive(nil, key, ...)
      --                      timeout key1        keys
      receive: function(self,         LdKeyNoNum, LdKey...): LdKey | cancel_error, any
      receive: function(self, number, LdKey,      LdKey...): LdKey | cancel_error, any

      --                      timeout batchedsen key    minnum   maxnum
      receive: function(self, number, LdBatched, LdKey, integer, ? integer): LdKey | cancel_error, any...

      --                    key    maxitems
      limit: function(self, LdKey, integer): boolean | cancel_error

      --                  key    items
      set: function(self, LdKey, any...): boolean | cancel_error

      --                  key    maxitems
      get: function(self, LdKey, ? integer): any...

      count: function(self, LdKey): integer
      count: function(self                 ): {LdKey:integer}
      count: function(self, LdKey, LdKey...): {LdKey:integer}

      dump: function(self): table

      cancel: function(self, CancelChoice)
   end

   interface ConfigureSettings
      nb_keepers: integer
      with_timers: boolean
      verbose_errors: boolean
      allocator: string
      internal_allocator: string
      demote_full_userdata: boolean
      track_lanes: boolean
      on_state_create: function()
      shutdown_timeout: number | integer
      -- keepers_gc_threshold: number | integer -- undocumented
   end
   configure: function(? ConfigureSettings): lanes

   register: function(string, function | table)

   enum GenLibs
      "base"
      ""
      "bit"
      "bit32"
      "coroutine"
      "debug"
      "ffi"
      "io"
      "jit"
      "math"
      "os"
      "package"
      "string"
      "table"
      "utf8"
      "*"
   end
   enum GcCallbackType
      "closed"
      "selfdestruct"
   end
   interface GenOpts
      globals: table
      required: {string}
      gc_cb: function(string, GcCallbackType)
      priority: integer
      package: table
   end
   type Generator = function(any...): Lane
   gen: function(                  function(any...): any...): Generator
   gen: function(GenOpts,          function(any...): any...): Generator
   gen: function(GenOpts, GenLibs, function(any...): any...): Generator
   gen: function(GenLibs,          function(any...): any...): Generator
   gen: function(GenLibs, GenOpts, function(any...): any...): Generator

   set_thread_priority: function(integer)
   set_thread_affinity: function(integer)

   linda: function(): Linda

   timer: function(Linda, Linda.LdKey, os.DateTable | number, ? number)

   timers: function(): {table}

   sleep: function(? number | boolean)

   enum Try
      "try"
   end

   type LockFunc = function(integer, ? Try): boolean | cancel_error
   genlock: function(Linda, Linda.LdKey, ? integer): LockFunc | cancel_error

   type AtomicFunc = function(? number): number | cancel_error
   genatomic: function(Linda, Linda.LdKey, ? number): AtomicFunc | cancel_error

   interface LaneRecord
      name: string
      status: Lane.Status
   end
   threads: function(): {LaneRecord}

   enum ErrorReporting
      "basic"
      "extended"
   end
   set_error_reporting: function(ErrorReporting)
end

-- these globals are only in lanes

global set_finalizer: function(function(any, any))
global cancel_test: function(): boolean

local enum ErrorReporting
   "basic"
   "extended"
end

global set_error_reporting: function(ErrorReporting)
global set_debug_threadname: function(? string): string

return lanes
