import 'package:flime/keyboard/basic/event.dart';

import 'context.dart';
import 'schema.dart';

class Engine {
  static Engine? _engine;

  Schema _schema;

  Context _context;

  late void Function(String) _onCommit;

  factory Engine() => _engine ??= Engine._init();

  Context get context => _context;

  set schema(Schema value) {
    _schema = value;
  }

  set onCommit(void Function(String) value) {
    _onCommit = value;
  }

  Engine._init()
      : _schema = Schema(),
        _context = Context() {
    _context.onChange = compose;
    _context.onCommit = commit;
  }

  Future<void> processKey(KEvent event) async {
    for (var preFilter in _schema.preFilters) {
      if (await preFilter.process(event)) {
        return;
      }
    }
  }

  Future compose() async {
    _context.candidates.clear();
    for (var translator in _schema.translators) {
      _context.candidates += await translator.process(_context.input);
    }
    for (var postFilter in _schema.postFilters) {
      postFilter.process(_context.candidates);
    }
  }

  void commit(String text) {
    _context.clear();
    _onCommit(text);
  }
}
