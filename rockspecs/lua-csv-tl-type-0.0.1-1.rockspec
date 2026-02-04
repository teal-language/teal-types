package = "lua-csv-tl-type"
version = "0.0.1-1"
source = {
   url = "git+https://github.com/teal-language/teal-types"
}
description = {
   summary = "Teal type definition files for lua-csv",
   detailed = [[
      The Teal type definition files allow users to install Teal
      type defintion for a given Lua package into their rocks tree.
   ]],
   homepage = "https://github.com/teal-language/teal-types",
   license = "MIT"
}

build = {
   type = "builtin",
   modules = {},
   install = {
      lua = {
         "types/lua-csv/csv.d.tl",
      }
   }
}
