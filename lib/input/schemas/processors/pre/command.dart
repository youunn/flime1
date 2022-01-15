import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/event/event.dart';
import 'package:flime/input/core/processors/pre_filter.dart';

class CommandFilter extends PreFilter {
  static CommandFilter? _filter;

  CommandFilter._();

  factory CommandFilter() => _filter ??= CommandFilter._();

  @override
  Future<PreFilterResult> process(Engine engine, KEvent event) async {
    if(event.type == EventType.operation) {
      return PreFilterResult.denied;
    }

    if (event.type == EventType.command) {
      event.command(engine);

      return PreFilterResult.finish;
    }

    return PreFilterResult.pass;
  }
}
