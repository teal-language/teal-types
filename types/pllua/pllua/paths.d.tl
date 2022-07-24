-- Module added in pllua version 2.0.2.

local record paths
   bin: function(): string
   lib: function(): string
   pkglib: function(): string
   libdir: function(): string
   share: function(): string
   locale: function(): string | nil
   -- The following directories may be defined but not exist:
   doc: function(): string | nil
   etc: function(): string | nil
   html: function(): string | nil
   include: function(): string | nil
   includeserver: function(): string | nil
   man: function(): string | nil
   pkginclude: function(): string | nil
end

return paths
