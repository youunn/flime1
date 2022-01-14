import 'package:flime/input/core/engine.dart';
import 'package:flime/input/schemas/options.dart';

typedef CommandEvent = Function(Engine);

class Commands {
  static bool _switchMode<T extends Enum>(Engine e, List<T> values, String key) {
    var value = e.getOption(key);
    if (value == null) return false;
    var index = value.index;
    var next = (index + 1) % values.length;
    e.setOption(key, values[next]);
    return true;
  }

  static void switchAsciiMode(Engine e) {
    if (_switchMode(e, AsciiMode.values, Options.asciiMode)) {
      e.context.clear();
    }
  }
}
