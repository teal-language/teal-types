package = "lualogging-tl-type"
version = "0.0.1-1"
source = {
   url = "git+https://github.com/teal-language/teal-types"
}
description = {
   summary = "Teal type definition files for lualogging",
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
         "types/lualogging/logging.d.tl",
         ["logging.rolling_file"] = "types/lualogging/logging/rolling_file.d.tl",
         ["logging.console"] = "types/lualogging/logging/console.d.tl",
         ["logging.file"] = "types/lualogging/logging/file.d.tl",
      }
   }
}
