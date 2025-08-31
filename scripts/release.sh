#!/bin/bash

set -eo pipefail

mkdir -p ./wasm
rm -rf ./wasm/*

SCRIPT_ROOT=$(dirname $0)

export FFMPEG_LGPL=true
export FFMPEG_SKIP_LIBS=false
$SCRIPT_ROOT/build.sh