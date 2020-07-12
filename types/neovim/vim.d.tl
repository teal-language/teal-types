
local API = require("nvim_api")
global vim = record
   api: API

   -- TODO: Either find a way to generate these or at least find a comprehensive list to put a bunch of 'TODO' stub definitions here
   --    Sadly, there doesn't seem to be a nice way to serialize all of these
   --    since they're lazily brought in as you call them
   --    this might be the only way since user defined functions are also called here
   --    ex vim.fn["MyPlugin#MyFunction"]() so
   -- VIM_fn = record -- if record maps were a thing
   --    {string:function(...: any): (any)}
   --    mode: function(): Mode
   --    ...
   -- end
   fn: {string:function(...: any): (any)}

   InspectOptions = record
      depth: number
      newline: string
      indent: string
      process: function
   end
   inspect: function(any)
   inspect: function(any, InspectOptions)

   paste: function({string}, number): boolean

   schedule_wrap: function(function())

   deep_equal: function(any, any)

   deepcopy: function<T>(T): T

   endswith: function(string, string): boolean

   gsplit: function(string, string): function(): string
   gsplit: function(string, string, boolean): function(): string

   is_callable: function(any): boolean

   list_extend: function<T, K>({T}, {K}): {T|K}
   list_extend: function<T, K>({T}, {K}, number): {T|K}
   list_extend: function<T, K>({T}, {K}, number, number): {T|K}

   pesc: function(string): string

   split: function(string, string): {string}
   split: function(string, string, boolean): {string}

   startswith: function(string, string): boolean

   tbl_add_reverse_lookup: function(table)

   tbl_contains: function<T>({T}, T): boolean

   ExtendBehavior = enum
      "error"
      "keep"
      "force"
   end
   tbl_extend: function(ExtendBehavior, table, table, ...: table)

   tbl_flatten: function({any|{any}}): {any}

   tbl_isempty: function(table): boolean

   tbl_islist: function(table): boolean

   tbl_keys: function<T>({T:any}): {T}

   tbl_values: function<T>({any:T}): {T}

   trim: function(string): string

   validate: function({string:{any}})

   Regex = record
      match_str: function(Regex, string): number, number

      match_line: function(Regex, number, number): number, number
      match_line: function(Regex, number, number, number): number, number
      match_line: function(Regex, number, number, number, number): number, number
   end
   regex: function(string): Regex

   loop = record
      Timer = record
         start: function(Timer, number, number, function)
         close: function(Timer)
      end
      new_timer: function(): Timer

      new_fs_event: function()

      new_tcp: function()
   end

   call: function(string, ...:any): any

   in_fast_event: function(): boolean

   NIL = record end -- special nil for filling tables, just a userdata

   empty_dict: function(): table

   rpcnotify: function(number, string, ...: string)

   rpcrequest: function(number, string, ...: string)

   stricmp: function(string, string): number

   str_utfindex: function(string): number, number
   str_utfindex: function(string, number): number, number

   str_byteindex: function(string, number): number
   str_byteindex: function(string, number, boolean): number

   schedule: function(function)

   type_idx: boolean

   val_idx: boolean

   types: {string|number:string|number}
end


return vim
