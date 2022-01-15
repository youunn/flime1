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
        if (event.click.isNormalChar) {
          if (await pushInput(engine, event.click.keyLabel.toLowerCase())) {
            return PreFilterResult.finish;
          } else {
            return PreFilterResult.pass;
          }
        }
      } else if (event.type == EventType.combo) {
        if (event.combo.modifiers == Modifiers.shift) {
          final click = event.combo.trigger;
          if (click.isNormalChar) {
            if (await pushInput(
              engine,
              click.keyLabel.toLowerCase(),
              shifted: true,
            )) {
              return PreFilterResult.finish;
            } else {
              return PreFilterResult.pass;
            }
          }
        }
      }

      return PreFilterResult.pass;
    }

    return PreFilterResult.pass;
  }

  Future<bool> pushInput(
    Engine engine,
    String text, {
    bool shifted = false,
  }) async {
    if (engine.context.hasCandidates) {
      final previousInput = engine.context.input;
      final input = (shifted && text.length == 1) ? text.toUpperCase() : text;

      final selector = text.selector;
      if (await engine.context.commitAt(selector)) return true;

      await engine.context.pushInput(input);

      if (!engine.context.hasCandidates) {
        await engine.context.setInput(previousInput);
        await engine.context.commitCurrent();
        // recursive
        return await pushInput(engine, input);
      } else if (engine.context.hasSingleCandidate) {
        await engine.context.commitCurrent();
      }
    } else {
      final input = (shifted && text.length == 1) ? text.toUpperCase() : text;
      await engine.context.pushInput(input);
      if (!engine.context.hasCandidates) {
        await engine.context.clear();
        return false;
      }
    }

    return true;
  }
}

extension _SelectorCheck on String {
  int get selector {
    if (length != 1) return -1;
    if (this == ' ') return 0;
    final value = int.tryParse(this);
    if (value == null) return -1;
    const limit = 3;
    if (value > limit || value < 1) return -1;
    return value - 1;
  }
}
