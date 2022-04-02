
global describe: function(string, function())
global it: function(string, function())
global before_each: function(function())
global after_each: function(function())
global setup: function(function())
global teardown: function(function())
global async: function()
global done: function()
global insulate: function(string, function())
global expose: function(string, function())
global randomize: function()
global finally: function(function())
global pending: function(string)

global record mock
   revert:function(any)

   new:function<T>(T, boolean):T
end

local record Stub
   was_called:function(string)
   was_not_called:function(string)

   was_called_with:function(any, string)
   was_not_called_with:function(any, string)

   revert:function(self:Stub)
end

global stub: function(any, string):Stub

local record Spy
   was_called:function(integer)
   was_not_called:function()

   was_called_with:function(...:any)
   was_not_called_with:function(...:any)

   clear:function(self:Spy)
   revert:function(self:Spy)

   metamethod __call: function(self: Spy, ...:any)
end

global record spy
   on:function(any, any):Spy
   new:function(function()):Spy
end

global record assert
   is_not_true:function(any, string)
   is_true:function(any, string)
   True:function(any, string)

   is_not_false:function(any, string)
   is_false:function(any, string)
   False:function(any, string)

   is_nil:function(any, string)
   is_not_nil:function(any, string)

   is_truthy:function(any, string)
   truthy:function(any, string)

   is_falsy:function(any, string)
   falsy:function(any, string)

   has_property:function(any, string, string)

   same:function(any, any, string)

   are_not_same:function(any, any, string)
   are_not_equal:function(any, any, string)
   are_not_equals:function(any, any, string)

   are_same:function(any, any, string)
   are_equal:function(any, any, string)
   are_equals:function(any, any, string)

   are_unique:function(any, any, string)
   are_not_unique:function(any, any, string)

   error:function(function(), string)

   has_no_errors:function(function(), string)
   has_error:function(function(), string)
   has_errors:function(function(), string)

   has_holes:function({any}, string)
   has_no_holes:function({any}, string)

   spy:function(any):Spy
   stub:function(any):Stub
end
