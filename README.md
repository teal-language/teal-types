Teal Types
====

[![Build Status](https://travis-ci.org/teal-language/teal-types.svg?branch=master)](https://travis-ci.org/teal-language/teal-types)

A collaborative repository containing Teal type definitions for Lua
libraries!

## How to use

To learn more about declaration files in Teal, see the [declaration files](https://github.com/teal-language/tl/blob/master/docs/declaration_files.md) page.

### Install types via LuaRocks
All the Teal Types [in this repo](https://github.com/teal-language/teal-types/tree/master/types) are uploaded to Luarocks can be installed into your local LuaRocks tree by running the following:

```
luarocks install [ORIGINAL_PACKAGE]-tl-type
```

For example, for `lua-cjson`:

```
luarocks install lua-cjson-tl-type
```

### Install types locally

Types can also be installed manually by going to the respective folder in [https://github.com/teal-language/teal-types/tree/master/types], and placing the `*.d.tl` files (and directories if present) in the `source_dir` file defined in `tl_config.lua` (if using [cyan](https://github.com/teal-language/cyan)) or directly next to your Teal script.

## Contribution guidelines

* For each Lua or C module, add one corresponding .d.tl file with the same name: e.g. for `lfs.so`, `lfs.d.tl`
* Folder names match those of their package entries in [LuaRocks](https://luarocks.org): e.g. `types/luafilesystem/lfs.d.tl`, because the `lfs` module is provided by the `luafilesystem` rock
* For modules that are not in LuaRocks, pick a reasonable project name (e.g. the name of the GitHub repository, with a suitable prefix to avoid conflicts if the name is too generic)

## License

MIT, same as Teal and Lua
