import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/processors/pre_filter.dart';
import 'package:flime/keyboard/basic/event.dart';

class SymbolFilter extends PreFilter {
  static SymbolFilter? _filter;

  SymbolFilter._();

  factory SymbolFilter() => _filter ??= SymbolFilter._();

  @override
  Future<preFilterResult> process(Engine engine, KEvent event) async {
    throw UnimplementedError();
  }
}
