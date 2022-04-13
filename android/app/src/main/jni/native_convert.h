#ifdef __cplusplus
extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif
char *convert(const char *configFile, const char *input);

#ifdef __cplusplus
extern "C" __attribute__((visibility("default"))) __attribute__((used))
#endif
char **convertList(const char *configFile, char **inputs, int length);
