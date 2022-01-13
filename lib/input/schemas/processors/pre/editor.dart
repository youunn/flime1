import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/processors/pre_filter.dart';
import 'package:flime/keyboard/basic/event.dart';
import 'package:flime/keyboard/basic/event_extension.dart';

class Editor extends PreFilter {
  static Editor? _editor;

  Editor._();

  factory Editor() => _editor ??= Editor._();

  @override
  Future<preFilterResult> process(Engine engine, KEvent event) async {
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
