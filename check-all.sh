#!/usr/bin/env sh

set -e
shopt -s globstar

for dir in types/*/; do
	for declfile in $dir**/*.d.tl; do
		tl check -I "$dir" "$declfile"
	done
done
