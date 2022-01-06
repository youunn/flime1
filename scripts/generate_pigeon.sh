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

# maybe there are some bugs in pigeon library when generate java code for @FlutterApi
sed -i 's/Reply<Long>/Reply<Number>/g' ./android/app/src/main/java/im/nue/flime/Pigeon.java
sed -i 's/Long output = (Long)channelReply/Number output = (Number)channelReply/g' ./android/app/src/main/java/im/nue/flime/Pigeon.java
