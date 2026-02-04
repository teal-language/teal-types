package = "luassert-tl-type"
version = "0.0.1-1"
source = {
   url = "git+https://github.com/teal-language/teal-types"
}
description = {
   summary = "Teal type definition files for luassert",
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
         ["luassert.assert"] = "types/luassert/luassert/assert.d.tl",
         ["luassert.spy"] = "types/luassert/luassert/spy.d.tl",
         ["luassert.stub"] = "types/luassert/luassert/stub.d.tl",
         ["luassert.mock"] = "types/luassert/luassert/mock.d.tl",
         ["luassert.match"] = "types/luassert/luassert/match.d.tl",
         "types/luassert/luassert.d.tl",
      }
   }
}
