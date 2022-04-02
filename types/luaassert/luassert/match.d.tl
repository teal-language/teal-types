
local record match
   _:any
   is_string:function()
   is_truthy:function()
   is_not_nil:function()
   is_not_false:function()
   is_not_number:function()
   is_not_table:function()
   is_equal:function(any)
   is_same:function(any)
   is_ref:function(any)
   is_boolean:function(any)
   is_table:function(any)
   is_number:function()
   is_all_of:function(...:any)
   is_any_of:function(...:any)
   is_none_of:function(...:any)
end

return match
