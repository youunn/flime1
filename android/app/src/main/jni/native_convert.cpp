#include <cstdint>
#include <Config.hpp>
#include <Converter.hpp>
#include <android/log.h>
#include "native_convert.h"

char *convert(const char *configFile, const char *input) {
    opencc::Config config;
    auto converter = config.NewFromFile(configFile);
    auto output = converter->Convert(input);
    char *result = (char *) malloc(output.size() + 1);
    strcpy(result, output.c_str());
    return result;
}

char **convertList(const char *configFile, char **inputs, int length) {
    opencc::Config config;
    auto converter = config.NewFromFile(configFile);

    char **outputs = (char **) malloc(sizeof(char *) * length);

    // __android_log_print(ANDROID_LOG_ERROR, "im.nue.flime", "length: %d", length);
    // __android_log_print(ANDROID_LOG_ERROR, "im.nue.flime", "config: %s", configFile);

    for (int i = 0; i < length; i++) {
        // __android_log_print(ANDROID_LOG_ERROR, "im.nue.flime", "convert input: %s", inputs[i]);
        auto output = converter->Convert(inputs[i]);
        char *result = (char *) malloc(output.size() + 1);
        strcpy(result, output.c_str());
        // __android_log_print(ANDROID_LOG_ERROR, "im.nue.flime", "convert result: %s", result);
        outputs[i] = result;
    }

    return outputs;
}
