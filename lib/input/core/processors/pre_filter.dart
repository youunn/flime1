import 'package:flime/input/core/engine.dart';
import 'package:flime/keyboard/basic/event.dart';

abstract class PreFilter {
  Engine engine;

  PreFilter(this.engine);

  Future<bool> process(KEvent event);
}
