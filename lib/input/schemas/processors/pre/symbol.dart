import 'package:characters/characters.dart';
import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/event/event.dart';
import 'package:flime/input/core/processors/pre_filter.dart';
import 'package:flime/input/schemas/options.dart';

class SymbolFilter extends PreFilter {
  static SymbolFilter? _filter;

  SymbolFilter._();

  factory SymbolFilter() => _filter ??= SymbolFilter._();

  final Map<String, Enum> _options = {
    Options.asciiMode: AsciiMode.no,
  };

  @override
  Map<String, Enum> get options => _options;

  @override
  Future<PreFilterResult> process(Engine engine, KEvent event) async {
    if (engine.getOption(Options.asciiMode) == AsciiMode.yes) {
      return PreFilterResult.pass;
    }

    if (event.type == EventType.click) {
      final v = _map[event.click.keyLabel];
      if (v != null && v.isNotEmpty) {
        if (v.length == 1) {
          await engine.context.commitDirectly(v);
        } else {
          await engine.context.commitCurrent();
          engine.context.candidates.addAll(v.characters);
        }
        return PreFilterResult.finish;
      } else {
        return PreFilterResult.pass;
      }
    }

    return PreFilterResult.pass;
  }

  static const Map<String, String> _map = {
    ',': '，',
    '.': '。',
    '<': '《',
    '>': '》',
    '?': '？',
    ';': '；',
    ':': '：',
    '\'': '‘’',
    '"': '“”',
    '\\': '、',
    '~': '～',
    '!': '！',
    '@': '@',
    '#': '＃',
    '\$': '￥',
    '%': '％',
    '^': '……',
    '&': '＆',
    '*': '＊',
    '(': '（',
    ')': '）',
    '[': '【',
    ']': '】',
    '{': '「',
    '}': '」',
  };
}
