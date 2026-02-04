package = "pllua-tl-type"
version = "0.0.1-1"
source = {
   url = "git+https://github.com/teal-language/teal-types"
}
description = {
   summary = "Teal type definition files for pllua",
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
         ["pllua.paths"] = "types/pllua/pllua/paths.d.tl",
         ["pllua.time"] = "types/pllua/pllua/time.d.tl",
         ["pllua.trusted"] = "types/pllua/pllua/trusted.d.tl",
         ["pllua.jsonb"] = "types/pllua/pllua/jsonb.d.tl",
         ["pllua.numeric"] = "types/pllua/pllua/numeric.d.tl",
         ["pllua.error"] = "types/pllua/pllua/error.d.tl",
         ["pllua.trigger"] = "types/pllua/pllua/trigger.d.tl",
         ["pllua.pgtype"] = "types/pllua/pllua/pgtype.d.tl",
         ["pllua.elog"] = "types/pllua/pllua/elog.d.tl",
         ["pllua.spi"] = "types/pllua/pllua/spi.d.tl",
      }
   }
}
