import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/event/event.dart';
import 'package:flime/input/core/event/event_extension.dart';
import 'package:flime/input/core/processors/pre_filter.dart';
import 'package:flime/input/schemas/options.dart';

class Editor extends PreFilter {
  static Editor? _editor;

  Editor._();

  factory Editor() => _editor ??= Editor._();

  final Map<String, Enum> _options = {
    Options.asciiMode: AsciiMode.no,
  };

  @override
  Map<String, Enum> get options => _options;

  @override
  Future<PreFilterResult> process(Engine engine, KEvent event) async {
    if (engine.getOption(Options.asciiMode) == AsciiMode.no) {
      if (event.type == EventType.click) {
        if (event.click.isBackspace) {
          if (engine.context.input.isNotEmpty) {
            await engine.context.popInput();
            return PreFilterResult.finish;
          }
          return PreFilterResult.denied;
        }

        if (event.click.isEnter) {
          if (engine.context.input.isNotEmpty) {
            await engine.context.commitDirectly(engine.context.input);
            return PreFilterResult.finish;
          } else {
            return PreFilterResult.denied;
          }
        }

        if (event.click.isNormalChar) {
          return PreFilterResult.pass;
        }

        return PreFilterResult.denied;
      }
    }

    if (event.type == EventType.combo) {
      return PreFilterResult.pass;
    }

    if (event.type == EventType.click &&
        (event.click.isEnter ||
            event.click.isBackspace ||
            event.click.isShift)) {
      return PreFilterResult.denied;
    } else {
      return PreFilterResult.pass;
    }
  }
}
