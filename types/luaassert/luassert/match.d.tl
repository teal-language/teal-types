
local record Matcher
    metamethod __call: function(self: Matcher, any)
end

local record match
   _:function(any)

   match:function(any):Matcher

   -- truthiness
   is_true:function():Matcher
   is_false:function():Matcher

   is_not_true:function():Matcher
   is_not_false:function():Matcher

   is_truthy:function():Matcher
   is_falsy:function():Matcher

   is_not_truthy:function():Matcher
   is_not_falsy:function():Matcher

   not_false:function():Matcher

   truthy:function():Matcher
   falsy:function():Matcher

   -- type matching
   is_boolean:function(any):Matcher
   is_function:function():Matcher
   is_nil:function():Matcher
   is_number:function():Matcher
   is_string:function():Matcher
   is_table:function(any):Matcher
   is_thread:function():Matcher
   is_ref:function(any):Matcher
   is_userdata:function():Matcher

   boolean:function(any):Matcher
   number:function():Matcher
   string:function():Matcher
   table:function(any):Matcher
   thread:function():Matcher
   userdata:function():Matcher
   ref:function():Matcher

   not_boolean:function(any):Matcher
   not_function:function():Matcher
   not_nil:function():Matcher
   not_number:function():Matcher
   not_string:function():Matcher
   not_table:function(any):Matcher
   not_thread:function():Matcher
   not_userdata:function():Matcher
   not_ref:function():Matcher

   is_not_boolean:function(any):Matcher
   is_not_function:function():Matcher
   is_not_nil:function():Matcher
   is_not_number:function():Matcher
   is_not_string:function():Matcher
   is_not_table:function(any):Matcher
   is_not_thread:function():Matcher
   is_not_userdata:function():Matcher
   is_not_ref:function():Matcher

   -- equality
   is_equals:function():Matcher
   is_equal:function(any):Matcher
   is_same:function(any):Matcher

   equals:function(any):Matcher
   equal:function(any):Matcher
   same:function(any):Matcher

   is_unique:function():Matcher
   is_not_unique:function():Matcher

   -- group matching
   is_all_of:function(...:any):Matcher
   is_any_of:function(...:any):Matcher
   is_none_of:function(...:any):Matcher

   all_of:function(...:any):Matcher
   any_of:function(...:any):Matcher
   none_of:function(...:any):Matcher

   not_all_of:function(...:any):Matcher
   not_any_of:function(...:any):Matcher
   not_none_of:function(...:any):Matcher

   -- misc
   matches:function(string, number):Matcher
   has_match:function(string, number):Matcher

   near:function(number, number):Matcher
   is_near:function(number, number):Matcher
   is_not_near:function(number, number):Matcher
end

return match
