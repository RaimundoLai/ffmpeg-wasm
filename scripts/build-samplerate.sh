#!/bin/bash

set -euo pipefail
source $(dirname $0)/var.sh

CONF_FLAGS=(
  --prefix=$BUILD_DIR                                 # install library in a build directory for FFmpeg to include
  --host=i686-gnu                                     # use i686 linux
  --enable-shared=no                                  # not to build shared library
  --disable-asm                                       # not to use asm
  --disable-rtcd                                      # not to detect cpu capabilities
  --disable-doc                                       # not to build docs
  --disable-extra-programs                            # not to build demo and tests
  --disable-stack-protector
)
echo "CONF_FLAGS=${CONF_FLAGS[@]}"

LIB_PATH1=modules/libsamplerate
(cd $LIB_PATH1 && \
  emconfigure ./autogen.sh && \
  CFLAGS=$CFLAGS emconfigure ./configure "${CONF_FLAGS[@]}")
emmake make -C $LIB_PATH1 clean
emmake make -C $LIB_PATH1 install

LIB_PATH2=modules/libsndfile
(cd $LIB_PATH2 && \
  emconfigure autoreconf -vif && \
  CFLAGS=$CFLAGS emconfigure ./configure "${CONF_FLAGS[@]}")
emmake make -C $LIB_PATH2 clean
emmake make -C $LIB_PATH2 install