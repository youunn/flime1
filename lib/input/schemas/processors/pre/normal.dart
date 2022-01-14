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
      if (event.type == EventType.click) {
        if (event.click.isAlphabet) {
          await pushInput(engine, event.click.keyLabel);
          return PreFilterResult.finish;
        }
      } else if (event.type == EventType.combo) {
        if (event.combo.modifiers == Modifiers.shift) {
          var click = event.combo.trigger;
          if (click.isAlphabet) {
            await pushInput(engine, click.keyLabel, shifted: true);
            return PreFilterResult.finish;
          }
        }
      }

      return PreFilterResult.denied;
    }

    return PreFilterResult.denied;
  }

  Future<void> pushInput(Engine engine,
      String text, {
        bool shifted = false,
      }) async {
    if (engine.context.hasCandidates) {
      var previousInput = engine.context.input;
      var input = shifted ? text : text.toLowerCase();
      await engine.context.pushInput(input);

      if (!engine.context.hasCandidates) {
        await engine.context.setInput(previousInput);
        engine.context.commitCurrent();
        await engine.context.setInput(input);
        if (!engine.context.hasCandidates) {
          engine.context.candidates.add(input);
          engine.context.commitCurrent();
        }
      } else if (engine.context.hasSingleCandidate) {
        engine.context.commitCurrent();
      }
    } else {
      var input = shifted ? text : text.toLowerCase();
      await engine.context.pushInput(input);
    }
  }
}
