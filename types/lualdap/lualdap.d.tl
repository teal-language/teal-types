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

      add: function(self: Cnx, name: DistinguishedName, table_of_attributes: {string:string|{string}}): function(): boolean, string
      bind_simple: function(self: Cnx, who: DistinguishedName, password: string): Cnx, string
      close: function(self: Cnx): integer
      compare: function(self: Cnx, name: DistinguishedName, attribute: string, value: string): function(): boolean, string
      delete: function(self: Cnx, name: DistinguishedName): function(): boolean, string
      modify: function(self: Cnx, name: DistinguishedName, ...: {integer|string:string|{string}}): function(): boolean, string
      rename: function(self: Cnx, name: DistinguishedName, new_relative_dn: DistinguishedName, new_parent: DistinguishedName, delete_old: integer): function(): boolean, string
      search: function(self: Cnx, params: Search): function(): DistinguishedName, {string:string|{string}}
   end

   open: function(hostname: string, usetls:boolean, timeout: number): Cnx, string
   open_simple: function(hostname: string, who: DistinguishedName, password: string, usetls: boolean, timeout: number): Cnx, string
end

return LuaLDAP
