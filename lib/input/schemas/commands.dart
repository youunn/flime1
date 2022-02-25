import 'package:flime/input/core/engine.dart';
import 'package:flime/input/schemas/options.dart';

typedef CommandEvent = Function(Engine);

bool _switchMode<T extends Enum>(Engine e, List<T> values, String key, {bool reverse = false}) {
  final value = e.getOption(key);
  if (value == null) return false;
  final index = value.index;
  final int next;
  if (!reverse) {
    next = (index + 1) % values.length;
  } else {
    next = (index - 1) % values.length;
  }
  e.setOption(key, values[next]);
  return true;
}

void switchAsciiMode(Engine e) {
  if (_switchMode(e, AsciiMode.values, Options.asciiMode)) {
    e.context.clear();
  }
}

void switchOpenCCOption(Engine e) {
  if (_switchMode(e, OpenCCOption.values, Options.opencc, reverse: false)) {
    e.context.clear();
  }
}

void switchOpenCCOptionReverse(Engine e) {
  if (_switchMode(e, OpenCCOption.values, Options.opencc, reverse: true)) {
    e.context.clear();
  }
}
