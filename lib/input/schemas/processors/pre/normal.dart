import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/processors/pre_filter.dart';
import 'package:flime/keyboard/basic/event.dart';
import 'package:flime/keyboard/basic/event_extension.dart';

class NormalFilter extends PreFilter {
  NormalFilter(Engine engine) : super(engine);

  @override
  Future<bool> process(KEvent event) async {
    if (event.click.isAlphabet) {
      if (engine.context.candidates.isNotEmpty) {
        var previousInput = engine.context.input;
        var input = event.click.keyLabel.toLowerCase();
        await engine.context.pushInput(input);

        if (engine.context.candidates.isEmpty) {
          await engine.context.setInput(previousInput);
          engine.context.commitCurrent();
          await engine.context.setInput(input);
        } else if (engine.context.candidates.length == 1) {
          engine.context.commitCurrent();
        }
      } else {
        var input = event.click.keyLabel.toLowerCase();
        await engine.context.pushInput(input);
      }
    }

    return true;
  }

}
