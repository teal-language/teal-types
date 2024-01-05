--
-- https://luarocks.org/modules/peterbillam/lgdbm
--

local record gdbm
   version: string

   record GDBM
      userdata

      close: function(self: GDBM)
      delete: function(self: GDBM, key: string): GDBM, string
      exists: function(self: GDBM, key: string): boolean
      export: function(self: GDBM, outputfile: string): GDBM, string
      fetch: function(self: GDBM, key: string): string
      firstkey: function(self: GDBM): string
      import: function(self: GDBM, inputdb: string, replace: boolean): GDBM, string
      insert: function(self: GDBM, key: string, data: string): GDBM, string
      nextkey: function(self: GDBM, key: string): string
      reorganize: function(self: GDBM): GDBM, string
      replace: function(self: GDBM, key: string, data: string): GDBM, string
      sync: function(self: GDBM): GDBM
   end

   open: function(filename: string, mode: string): GDBM, string
end

return gdbm
