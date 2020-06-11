Teal Types
====

[![Build Status](https://travis-ci.org/teal-language/teal-types.svg?branch=master)](https://travis-ci.org/teal-language/teal-types)

A collaborative repository containing Teal type definitions for Lua
libraries!

## Contribution guidelines

* For each Lua or C module, add one corresponding .d.tl file with the same name: e.g. for `lfs.so`, `lfs.d.tl`
* Folder names match those of their package entries in [LuaRocks](https://luarocks.org): e.g. `types/luafilesystem/lfs.d.tl`, because the `lfs` module is provided by the `luafilesystem` rock
* For modules that are not in LuaRocks, pick a reasonable project name (e.g. the name of the GitHub repository, with a suitable prefix to avoid conflicts if the name is too generic)

## License

MIT, same as Teal and Lua
