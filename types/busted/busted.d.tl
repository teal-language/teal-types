
global describe: function(string, function())
global it: function(string, function())
global before_each: function(function())
global after_each: function(function())
global setup: function(function())
global teardown: function(function())
global async: function()
global done: function()

global record spy
   on:function(any, any)
end

global record assert
   is_not_true:function(boolean, string)
   is_true:function(boolean, string)
   True:function(boolean, string)

   is_not_false:function(boolean, string)
   is_false:function(boolean, string)
   False:function(boolean, string)

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

   record Spy
      was_called:function(string)
      was_not_called:function(string)

      was_called_with:function(any, string)
      was_not_called_with:function(any, string)
   end

   spy:function(any):Spy

   record Stub
      was_called:function(string)
      was_not_called:function(string)

      was_called_with:function(any, string)
      was_not_called_with:function(any, string)
   end

   stub:function(any):Stub
end
