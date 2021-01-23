#!/usr/bin/env bash

shopt -s globstar

err=0
trap 'err=1' ERR

# Lua 5.1/JIT does not include ./?/init.lua by default.
# Add it to ensure Teal over Lua 5.1/JIT sees ./?/init.d.tl files.
export LUA_PATH="./?.lua;./?/init.lua;$LUA_PATH"

for dir in types/*/; do
	pushd "$dir" > /dev/null
	for declfile in **/*.d.tl; do
		tl --quiet check "$declfile"
	done
	popd > /dev/null
done

exit $err
