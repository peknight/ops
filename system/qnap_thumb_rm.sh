#!/bin/bash
target_path=.
if [ -d "$1" ]; then
    target_path=$1
fi
find ${target_path} -type d -name .@__thumb -exec rm -r {} \;
