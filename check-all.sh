#!/usr/bin/env bash

shopt -s globstar

err=0
trap 'err=1' ERR

for dir in types/*/; do
	pushd "$dir" > /dev/null
	for declfile in **/*.d.tl; do
		tl check "$declfile" 1> /dev/null
	done
	popd > /dev/null
done

exit $err
