import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/event/event.dart';
import 'package:flime/input/core/processors/pre_filter.dart';

class Selector extends PreFilter {
  static Selector? _filter;

  Selector._();

  factory Selector() => _filter ??= Selector._();

  @override
  Future<PreFilterResult> process(Engine engine, KEvent event) async {
    throw UnimplementedError();
  }
}
