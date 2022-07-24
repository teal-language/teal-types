local record trusted
   enum TrustedMode
      "direct"
      "copy"
      "proxy"
      "sproxy"
   end
   -- module can be: a module name, an array of module names or an array of the 5-uples of the allow function:
   type Module = string | {string | {string, string, TrustedMode, boolean|string, boolean}}

   allow: function(module: Module, newname: string|nil, mode: TrustedMode, global: boolean|string, preload: boolean)
   require: function(module: Module, newname: string, mode: TrustedMode)  -- equiv. to trusted.allow(module, newname, mode, true, true)
   remove: function(newname: string, global: boolean|string)
end

return trusted
