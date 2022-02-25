import 'package:flime/input/core/engine.dart';

abstract class PostFilter {
  Map<String, Enum> get options => {};

  Future<List<String>> process(List<String> candidates, Engine engine);
}
