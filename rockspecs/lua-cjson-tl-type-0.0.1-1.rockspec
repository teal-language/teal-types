package = "lua-cjson-tl-type"
version = "0.0.1-1"
source = {
   url = "git+https://github.com/teal-language/teal-types"
}
description = {
   summary = "Teal type definition files for lua-cjson",
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
         ["cjson.safe"] = "types/lua-cjson/cjson/safe.d.tl",
         "types/lua-cjson/cjson.d.tl",
      }
   }
}
