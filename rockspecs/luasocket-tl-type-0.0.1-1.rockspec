package = "luasocket-tl-type"
version = "0.0.1-1"
source = {
   url = "git+https://github.com/teal-language/teal-types"
}
description = {
   summary = "Teal type definition files for luasocket",
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
         "types/luasocket/ltn12.d.tl",
         "types/luasocket/socket.d.tl",
         ["socket.headers"] = "types/luasocket/socket/headers.d.tl",
         ["socket.url"] = "types/luasocket/socket/url.d.tl",
         ["socket.ftp"] = "types/luasocket/socket/ftp.d.tl",
         ["socket.http"] = "types/luasocket/socket/http.d.tl",
         ["socket.smtp"] = "types/luasocket/socket/smtp.d.tl",
         "types/luasocket/mime.d.tl",
      }
   }
}
