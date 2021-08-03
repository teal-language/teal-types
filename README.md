Teal Types
====

[![Build Status](https://travis-ci.org/teal-language/teal-types.svg?branch=master)](https://travis-ci.org/teal-language/teal-types)

A collaborative repository containing Teal type definitions for Lua
libraries!

## How to use

To learn more about declaration files in Teal, see the [declaration files](https://github.com/teal-language/tl/blob/master/docs/declaration_files.md) page.

For the time being, the best way to install the declaration files on your machine is to copy them into your project. In the future, this step may be automated (see [issue #21](https://github.com/teal-language/teal-types/issues/21))

## Contribution guidelines

* For each Lua or C module, add one corresponding .d.tl file with the same name: e.g. for `lfs.so`, `lfs.d.tl`
* Folder names match those of their package entries in [LuaRocks](https://luarocks.org): e.g. `types/luafilesystem/lfs.d.tl`, because the `lfs` module is provided by the `luafilesystem` rock
* For modules that are not in LuaRocks, pick a reasonable project name (e.g. the name of the GitHub repository, with a suitable prefix to avoid conflicts if the name is too generic)

## License

MIT, same as Teal and Lua
