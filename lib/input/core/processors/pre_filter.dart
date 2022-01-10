import 'package:flime/input/core/engine.dart';
import 'package:flime/keyboard/basic/event.dart';

abstract class PreFilter {
  Engine engine;

  PreFilter(this.engine);

  Future<preFilterResult> process(KEvent event);
}

enum preFilterResult {
  pass,
  finish,
  denied,
}