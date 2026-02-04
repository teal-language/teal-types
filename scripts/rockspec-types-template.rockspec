package = "%s-tl-type"
version = "%s-1"
source = {
   url = "git+https://github.com/teal-language/teal-types"
}
description = {
   summary = "Teal type definition files for %s",
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
%s
      }
   }
}
