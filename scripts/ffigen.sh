#!/bin/sh

cd "$(dirname "$0")" || exit
cd ..
mkdir -p ./lib/api
dart run ffigen