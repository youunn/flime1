import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/processors/pre_filter.dart';
import 'package:flime/keyboard/basic/event.dart';
import 'package:flime/keyboard/basic/event_extension.dart';

class NormalFilter extends PreFilter {
  NormalFilter(Engine engine) : super(engine);

  @override
  Future<preFilterResult> process(KEvent event) async {
    if (event.click.isAlphabet) {
      if (engine.context.hasCandidates) {
        var previousInput = engine.context.input;
        var input = event.click.keyLabel.toLowerCase();
        await engine.context.pushInput(input);

        if (!engine.context.hasCandidates) {
          await engine.context.setInput(previousInput);
          engine.context.commitCurrent();
          await engine.context.setInput(input);
        } else if (engine.context.hasSingleCandidate) {
          engine.context.commitCurrent();
        }
      } else {
        var input = event.click.keyLabel.toLowerCase();
        await engine.context.pushInput(input);
      }
      return preFilterResult.finish;
    }

    return preFilterResult.denied;
  }
}
