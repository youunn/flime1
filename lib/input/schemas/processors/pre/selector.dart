import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/processors/pre_filter.dart';
import 'package:flime/keyboard/basic/event.dart';

class Selector extends PreFilter {
  Selector(Engine engine) : super(engine);

  @override
  Future<bool> process(KEvent event) async {
    throw UnimplementedError();
  }

}