import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/event/event.dart';

abstract class PreFilter {
  Map<String, Enum> get options => {};

  Future<PreFilterResult> process(Engine engine, KEvent event);
}

enum PreFilterResult {
  pass,
  finish,
  denied,
}
