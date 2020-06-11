#!/usr/bin/env sh

shopt -s globstar

err=0
trap 'err=1' ERR

for dir in types/*/; do
	for declfile in $dir**/*.d.tl; do
		tl check -I "$dir" "$declfile"
	done
done

exit $err
