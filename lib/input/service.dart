import 'package:flime/input/core/engine.dart';
import 'package:flime/keyboard/basic/event.dart';

class Service {
  final Engine _engine;
  String _commitText;

  Service()
      : _engine = Engine(),
        _commitText = '' {
    _engine.onCommit = _commit;
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

  String get input => _engine.context.input;
  List<String> get candidates => _engine.context.candidates;
}
