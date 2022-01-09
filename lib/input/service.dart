import 'package:flime/input/core/engine.dart';
import 'package:flime/keyboard/basic/event.dart';

class Service {
  static Service? _service;

  factory Service() => _service ??= Service._init();

  Service._init()
      : _engine = Engine(),
        _commitText = '' {
    _engine.onCommit = commit;
  }

  Engine _engine;

  String _commitText;

  void destroy() {
    _service = null;
  }

  String get commitText => _commitText;

  Engine get engine => _engine;

  // 接收按键后，`Engine`监听`Context`的变化，将编码转换为候选字，并对候选字后处理，添加到
  // `Context`（中间件都不要了）。这一步可能在`Processor`处理按键的过程中进行。
  Future onKey(KEvent event) => _engine.processKey(event);

  void commit(String text) => _commitText += text;

  void resetCommitText() => _commitText = '';

  String popCommitText() {
    var s = _commitText;
    resetCommitText();
    return s;
  }
}
