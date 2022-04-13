#!/bin/sh

cd "$(dirname "$0")" || exit
cd ..
mkdir -p ./lib/api
flutter pub run ffigen
