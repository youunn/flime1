import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/processors/pre_filter.dart';
import 'package:flime/keyboard/basic/event.dart';

class SymbolFilter extends PreFilter {
  SymbolFilter(Engine engine) : super(engine);

  @override
  Future<preFilterResult> process(KEvent event) async {
    throw UnimplementedError();
  }
}
