import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/event/event.dart';
import 'package:flime/input/core/event/event_extension.dart';
import 'package:flime/input/core/processors/pre_filter.dart';
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
          await pushInput(engine, event.click.keyLabel.toLowerCase());
          return PreFilterResult.finish;
        }
      } else if (event.type == EventType.combo) {
        if (event.combo.modifiers == Modifiers.shift) {
          final click = event.combo.trigger;
          if (click.isAlphabet) {
            // TODO: 这样shift就变成caps lock了，还是一次性的比较常用吧
            await pushInput(
              engine,
              click.keyLabel.toLowerCase(),
              shifted: true,
            );
            return PreFilterResult.finish;
          }
        }
      }

      return PreFilterResult.denied;
    }

    return PreFilterResult.denied;
  }

  Future<void> pushInput(
    Engine engine,
    String text, {
    bool shifted = false,
  }) async {
    if (engine.context.hasCandidates) {
      final previousInput = engine.context.input;
      final input = (shifted && text.length == 1) ? text.toUpperCase() : text;
      await engine.context.pushInput(input);

      if (!engine.context.hasCandidates) {
        if (previousInput.isEmpty) {
          engine.context.commitDirectly(input);
        } else {
          await engine.context.setInput(previousInput);
          engine.context.commitCurrent();
          // recursive
          await pushInput(engine, input);
        }
      } else if (engine.context.hasSingleCandidate) {
        engine.context.commitCurrent();
      }
    } else {
      final input = (shifted && text.length == 1) ? text.toUpperCase() : text;
      await engine.context.pushInput(input);
      if (!engine.context.hasCandidates) {
        await engine.context.clear();
        engine.context.commitDirectly(input);
      }
    }
  }
}
