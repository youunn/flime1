extern "C" __attribute__((visibility("default"))) __attribute__((used))
char *convert(const char *configFile, const char *input);

extern "C" __attribute__((visibility("default"))) __attribute__((used))
char **convertList(const char *configFile, char **inputs, int length);
