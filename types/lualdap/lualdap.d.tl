--
-- https://luarocks.org/modules/fperrad/lualdap
--

local record LuaLDAP
   _COPYRIGHT: string
   _DESCRIPTION: string
   _VERSION: string

   type DistinguishedName = string

   record Cnx
      userdata

      type TableOfAttributes = {string:string|{string}}
      type TableOfOperations = {integer|string:string|{string}}
      type ResultFunction = function(): boolean, string

      record Search
         enum Scope
            "base"
            "onelevel"
            "subtree"
            ""
         end

         attrs: string|{string}
         attrsonly: boolean
         base: DistinguishedName
         filter: string
         scope: Scope
         sizelimit: integer
         timeout: number
      end

      add: function(self: Cnx, name: DistinguishedName, attributes: TableOfAttributes): ResultFunction
      bind_simple: function(self: Cnx, who: DistinguishedName, password: string): Cnx, string
      close: function(self: Cnx): integer
      compare: function(self: Cnx, name: DistinguishedName, attribute: string, value: string): ResultFunction
      delete: function(self: Cnx, name: DistinguishedName): ResultFunction
      modify: function(self: Cnx, name: DistinguishedName, ...: TableOfOperations): ResultFunction
      rename: function(self: Cnx, name: DistinguishedName, new_rdn: DistinguishedName, new_parent: DistinguishedName, delete_old: integer): ResultFunction
      search: function(self: Cnx, params: Search): function(): DistinguishedName, TableOfAttributes
   end

   open: function(hostname: string, usetls:boolean, timeout: number): Cnx, string
   open_simple: function(hostname: string, who: DistinguishedName, password: string, usetls: boolean, timeout: number): Cnx, string
end

return LuaLDAP
