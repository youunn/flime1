import 'package:flime/input/core/processors/pre_filter.dart';
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

  Future<bool> processKey(KEvent event) async {
    for (var preFilter in _schema.preFilters) {
      var result = await preFilter.process(event);
      switch (result) {
        case preFilterResult.finish:
          return true;
        case preFilterResult.denied:
          return false;
        case preFilterResult.pass:
          break;
      }
    }

    return false;
  }

  Future compose() async {
    if (_context.input.isNotEmpty) {
      _context.candidates.clear();
      for (var translator in _schema.translators) {
        _context.candidates.addAll(await translator.process(_context.input));
      }
      for (var postFilter in _schema.postFilters) {
        var filtered = postFilter.process(_context.candidates);
        _context.candidates.clear();
        _context.candidates.addAll(filtered);
      }
    }
  }

  void commit(String text) {
    _onCommit(text);
  }
}
