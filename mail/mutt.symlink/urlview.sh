#!/bin/sh

HAS_URLSCAN=1
command -v urlscan >/dev/null 2>&1 || { HAS_URLSCAN=0; }

if [ $HAS_URLSCAN = 1 ]; then
	export BROWSER=open
	urlscan "$@"
else
	urlview "$@"
fi