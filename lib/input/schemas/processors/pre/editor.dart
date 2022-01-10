import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/processors/pre_filter.dart';
import 'package:flime/keyboard/basic/event.dart';
import 'package:flime/keyboard/basic/event_extension.dart';

class Editor extends PreFilter {
  Editor(Engine engine) : super(engine);

  @override
  Future<preFilterResult> process(KEvent event) async {
    // 不要在没有composing时发backspace，enter过来，让client自己处理
    // 或者发过来然后返回未处理，比如空格或英文模式下所有字符
    if (event.click.isBackspace) {
      if (engine.context.input.isNotEmpty) {
        await engine.context.popInput();
        return preFilterResult.finish;
      }
      return preFilterResult.denied;
    } else if (event.click.isSpace) {
      if (engine.context.hasCandidates) {
        engine.context.commitCurrent();
        return preFilterResult.finish;
      } else if (engine.context.input.isEmpty) {
        return preFilterResult.denied;
      }
    } else if (event.click.isAlphabet) {
      return preFilterResult.pass;
    }

    return preFilterResult.denied;
  }
}
