import 'package:flutter/widgets.dart';

class Engine {
  static Engine? _engine;

  factory Engine() {
    _engine ??= Engine._init();
    return _engine!;
  }

  Engine._init() {}

  // 借用一下RawKeyEvent
  bool processKey(RawKeyEvent keyEvent) {
    return false;
  }

  bool commit(String text) {
    return false;
  }
}
