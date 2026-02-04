# Scripts for using `teal-types`

## `deploy_luarocks.lua`

Usage: `lua deploy_luarocks.lua` or `tl run deploy_luarocks.tl`

Scans through your local `luarocks` tree, finds `.{lua|dll|so}` files, and
deploys the corresponding `.d.tl` files from here to the Lua tree.
It also lists modules that you have installed, but that don't have any matching
`.d.tl` files here.
Note that this script must be run from within the scripts directory.


## `read_luarocks.lua`

Usage: `lua read_luarocks.lua` or `tl run read_luarocks.tl`

Scans for `.d.tl` files under your local `luarocks` tree and copies them here.
Note that this script must be run from within the scripts directory.

## `generate_rockspecs.tl`

NOTE: This file should be run from the root of the repository and not from
within the scripts directory! This script also requires `git` to be available.

Usage: `lua ./scripts/generate_rockspecs.lua` or
`tl run ./scripts/generate_rockspecs.tl`

Generates rockspecs in `./rockspecs/` for all the teal types in `./types` and 
saves off the last git commit it ran from in `./scripts/previous-sha`.

## Requirements

- `lua` and `luarocks` must be installed. &#x1f926;

- `lfs` is used if available.


## Notes

- `vendored/ltn12.lua` is from `luasocket` by Diego Nehab

- `vendored/lfs.lua` is a simplified version of `lfs` written in pure
  Lua that just has the functionality necessary for these scripts.
