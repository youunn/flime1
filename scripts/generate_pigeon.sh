#!/bin/sh

cd "$(dirname "$0")" || exit
cd ..
mkdir -p ./lib/api
mkdir -p ./android/app/src/main/java/im/nue/flime

flutter pub run pigeon \
    --input ./pigeons/api.dart \
    --dart_out ./lib/api/api.dart \
    --java_out ./android/app/src/main/java/im/nue/flime/Pigeon.java \
    --java_package "im.nue.flime"