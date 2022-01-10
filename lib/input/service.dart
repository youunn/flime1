import 'package:flime/input/core/engine.dart';
import 'package:flime/input/schemas/default_schema.dart';
import 'package:flime/keyboard/basic/event.dart';

// TODO: 加一个ChangeNotifier
class Service {
  static Service? _service;

  factory Service() => _service ??= Service._init();

  Service._init()
      : _engine = Engine(),
        _commitText = '' {
    Schemas.engine = _engine;
    _engine.onCommit = _commit;
  }

  Engine _engine;

  String _commitText;

  void destroy() {
    // 有个DI就完美了
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

  List<String> get candidates => _engine.context.candidates;
}
