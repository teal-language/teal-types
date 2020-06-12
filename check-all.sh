#!/usr/bin/env sh

shopt -s globstar

err=0
trap 'err=1' ERR

for dir in types/*/; do
	pushd "$dir"
	for declfile in **/*.d.tl; do
		tl check "$declfile"
	done
	popd
done

exit $err
