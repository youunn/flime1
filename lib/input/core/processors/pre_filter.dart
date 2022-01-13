import 'package:flime/input/core/engine.dart';
import 'package:flime/keyboard/basic/event.dart';

abstract class PreFilter {
  Future<preFilterResult> process(Engine engine, KEvent event);
}

enum preFilterResult {
  pass,
  finish,
  denied,
}