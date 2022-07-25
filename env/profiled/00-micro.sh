#!/bin/bash
declare micro_loc
if micro_loc="$(command -v micro 2>/dev/null)"
then
	alias micro="${micro_loc} -config-dir '${HOME}/Library/Application Support/Micro-Editor'"
	mkdir "${HOME}/Library/Application Support/Micro-Editor"
fi
unset micro_loc
