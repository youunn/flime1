import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/processors/pre_filter.dart';
import 'package:flime/keyboard/basic/event.dart';
import 'package:flime/keyboard/basic/event_extension.dart';

class Editor extends PreFilter {
  Editor(Engine engine) : super(engine);

  @override
  Future<bool> process(KEvent event) async {
    if (event.click.isBackspace) {
      // 不要在没有composing时发backspace，enter过来，让client自己处理
      if (engine.context.input.isNotEmpty) {
        await engine.context.popInput();
      }
      return true;
    } else if (event.click.isSpace) {
      engine.context.commitCurrent();
      return true;
    }

    return false;
  }
}
