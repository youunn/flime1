abstract class Translator {
  Map<String, Enum> get options => {};

  Future<List<String>> process(String input);
}
