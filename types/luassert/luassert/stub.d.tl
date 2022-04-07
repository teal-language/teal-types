
local record stub
   record Defaults
      returns:function(...:any)
      invokes:function(function(...:any))
   end

   record OnCallWith
      returns:function(...:any)
      invokes:function(function(...:any))
   end

   clear:function(self:stub):stub
   revert:function(self:stub):stub

   on_call_with:function(...:any):OnCallWith

   returns:function(...:any):stub
   invokes:function(function(...:any)):stub

   -- table, key, return values
   new:function(any, string, ...:any):stub

   by_default:Defaults

   metamethod __call: function(self: stub, ...:any)
end

return stub
