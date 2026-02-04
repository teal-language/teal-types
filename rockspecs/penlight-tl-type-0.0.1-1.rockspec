package = "penlight-tl-type"
version = "0.0.1-1"
source = {
   url = "git+https://github.com/teal-language/teal-types"
}
description = {
   summary = "Teal type definition files for penlight",
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
         ["pl.data"] = "types/penlight/pl/data.d.tl",
         ["pl.class"] = "types/penlight/pl/class.d.tl",
         ["pl.pretty"] = "types/penlight/pl/pretty.d.tl",
         ["pl.url"] = "types/penlight/pl/url.d.tl",
         ["pl.utils"] = "types/penlight/pl/utils.d.tl",
         ["pl.permute"] = "types/penlight/pl/permute.d.tl",
         ["pl.operator"] = "types/penlight/pl/operator.d.tl",
         ["pl.List"] = "types/penlight/pl/List.d.tl",
         ["pl.array2d"] = "types/penlight/pl/array2d.d.tl",
         ["pl.seq"] = "types/penlight/pl/seq.d.tl",
         ["pl.compat"] = "types/penlight/pl/compat.d.tl",
         ["pl.stringx"] = "types/penlight/pl/stringx.d.tl",
         ["pl.luabalanced"] = "types/penlight/pl/luabalanced.d.tl",
         ["pl.text"] = "types/penlight/pl/text.d.tl",
         ["pl.comprehension"] = "types/penlight/pl/comprehension.d.tl",
         ["pl.stringio"] = "types/penlight/pl/stringio.d.tl",
         ["pl.Map"] = "types/penlight/pl/Map.d.tl",
         ["pl.path"] = "types/penlight/pl/path.d.tl",
         ["pl.tablex"] = "types/penlight/pl/tablex.d.tl",
         ["pl.lapp"] = "types/penlight/pl/lapp.d.tl",
         ["pl.dir"] = "types/penlight/pl/dir.d.tl",
         ["pl.Date"] = "types/penlight/pl/Date.d.tl",
         ["pl.app"] = "types/penlight/pl/app.d.tl",
         ["pl.template"] = "types/penlight/pl/template.d.tl",
         ["pl.xml"] = "types/penlight/pl/xml.d.tl",
         ["pl.types"] = "types/penlight/pl/types.d.tl",
         ["pl.input"] = "types/penlight/pl/input.d.tl",
         ["pl.config"] = "types/penlight/pl/config.d.tl",
         ["pl.lexer"] = "types/penlight/pl/lexer.d.tl",
         ["pl.file"] = "types/penlight/pl/file.d.tl",
         ["pl.test"] = "types/penlight/pl/test.d.tl",
         ["pl.func"] = "types/penlight/pl/func.d.tl",
         ["pl.strict"] = "types/penlight/pl/strict.d.tl",
         ["pl.sip"] = "types/penlight/pl/sip.d.tl",
         "types/penlight/pl.d.tl",
      }
   }
}
