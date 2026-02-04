package = "hump-tl-type"
version = "0.0.1-1"
source = {
   url = "git+https://github.com/teal-language/teal-types"
}
description = {
   summary = "Teal type definition files for hump",
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
         "types/hump/vector-light.d.tl",
         "types/hump/vector.d.tl",
         "types/hump/signal.d.tl",
         "types/hump/camera.d.tl",
         "types/hump/gamestate.d.tl",
         "types/hump/timer.d.tl",
      }
   }
}
