
local record spy
   clear:function(self:spy):spy
   revert:function(self:spy):spy

   on:function(any, string):spy

   -- To call spy methods, cast it back to spy with 'as'
   new:function<T>(T):T

   metamethod __call: function(self: spy, ...:any)
end

return spy
