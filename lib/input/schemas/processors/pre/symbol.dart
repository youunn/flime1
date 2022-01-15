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
    throw UnimplementedError();
  }
}
