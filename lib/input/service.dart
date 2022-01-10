import 'package:flime/input/core/engine.dart';
import 'package:flime/keyboard/basic/event.dart';

class Service {
  static Service? _service;

  factory Service() => _service ??= Service._init();

  Service._init()
      : _engine = Engine(),
        _commitText = '' {
    _engine.onCommit = _commit;
  }

  Engine _engine;

  String _commitText;

  void destroy() {
    _service = null;
  }

  String get commitText => _commitText;

  Engine get engine => _engine;

  Future<bool> onKey(KEvent event) => _engine.processKey(event);

  String popCommitText() {
    var s = _commitText;
    _commitText = '';
    return s;
  }

  void _commit(String text) {
    _commitText += text;
  }
}
