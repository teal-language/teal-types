
local record say
   set_namespace:function(self:say, string)
   set:function(self:say, string, string)

   metamethod __call: function(self: say, string, {any})
end

return say
