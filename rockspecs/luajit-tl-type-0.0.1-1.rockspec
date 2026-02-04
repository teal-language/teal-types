package = "luajit-tl-type"
version = "0.0.1-1"
source = {
   url = "git+https://github.com/teal-language/teal-types"
}
description = {
   summary = "Teal type definition files for luajit",
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
         ["table.new"] = "types/luajit/table/new.d.tl",
         ["table.clear"] = "types/luajit/table/clear.d.tl",
         "types/luajit/ffi.d.tl",
         ["string.buffer"] = "types/luajit/string/buffer.d.tl",
         "types/luajit/jit.d.tl",
      }
   }
}
