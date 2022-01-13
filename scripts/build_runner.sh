#!/bin/sh

cd "$(dirname "$0")" || exit
cd ..

flutter packages pub run build_runner build