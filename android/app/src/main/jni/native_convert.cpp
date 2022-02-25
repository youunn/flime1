#include <android/log.h>
#include <opencc/Config.hpp>
#include <opencc/Converter.hpp>
#include <opencc/Conversion.hpp>
#include <opencc/ConversionChain.hpp>
#include <opencc/Dict.hpp>
#include <opencc/DictEntry.hpp>

#include "native_convert.h"

char *convert(const char *configFile, const char *input) {
    opencc::Config config;
    // __android_log_print(ANDROID_LOG_ERROR, "im.nue.flime", "config: %s", configFile);
    auto converter = config.NewFromFile(configFile);
    auto output = converter->Convert(input);
    char *result = (char *) malloc(output.size() + 1);
    std::strcpy(result, output.c_str());
    return result;
}
char **convertList(const char *configFile, char **inputs, int length) {
    try {
        opencc::Config config;
        auto converter = config.NewFromFile(configFile);
        auto dict = converter->GetConversionChain()->GetConversions().front()->GetDict();

        std::vector<std::string> results;
        results.reserve(length);
        for (int i = 0; i < length; i++) {
            auto matches = dict->Match(inputs[i]);
            if (matches.IsNull()) {
                results.push_back(converter->Convert(inputs[i]));
            } else {
                for (auto &&value: matches.Get()->Values()) {
                    results.push_back(std::move(value));
                }
            }
        }
        results.shrink_to_fit();

        auto outputs = (char **) malloc(sizeof(char *) * (results.size() + 1));
        auto i = 0;
        for (auto &s: results) {
            auto ss = (char *) malloc(sizeof(char) * (s.length() + 1));
            std::strcpy(ss, s.c_str());
            outputs[i] = ss;
            i++;
        }

        outputs[i] = nullptr;

        return outputs;
    } catch (std::exception &e) {
        __android_log_print(ANDROID_LOG_ERROR, "im.nue.flime", "error: %s", e.what());
        return nullptr;
    }
}
