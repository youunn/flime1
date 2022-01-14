import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/processors/pre_filter.dart';
import 'package:flime/input/core/event/event.dart';
import 'package:flime/input/core/event/event_extension.dart';
import 'package:flime/input/schemas/options.dart';

class NormalFilter extends PreFilter {
  static NormalFilter? _filter;

  NormalFilter._();

  factory NormalFilter() => _filter ??= NormalFilter._();

  final Map<String, Enum> _options = {
    Options.asciiMode: AsciiMode.no,
  };

  @override
  Map<String, Enum> get options => _options;

  @override
  Future<PreFilterResult> process(Engine engine, KEvent event) async {
    if (engine.getOption(Options.asciiMode) == AsciiMode.no) {
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
        return PreFilterResult.finish;
      }

      return PreFilterResult.denied;
    }

    return PreFilterResult.denied;
  }
}
