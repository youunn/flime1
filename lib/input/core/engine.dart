import 'package:flime/input/core/processors/pre_filter.dart';
import 'package:flime/keyboard/basic/event.dart';

import 'context.dart';
import 'schema.dart';

class Engine {
  Schema _schema;
  final Context _context;
  late void Function(String) _onCommit;

  Engine()
      : _schema = Schema(),
        _context = Context() {
    _context.onChange = compose;
    _context.onCommit = commit;
  }

  Context get context => _context;

  set schema(Schema value) => _schema = value;

  Future setSchemaAsync(Future<Schema> value) async => _schema = await value;

  set onCommit(void Function(String) value) => _onCommit = value;

  Future<bool> processKey(KEvent event) async {
    for (var preFilter in _schema.preFilters) {
      var result = await preFilter.process(this, event);
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
    } else if (_context.candidates.isNotEmpty) {
      _context.candidates.clear();
    }
  }

  void commit(String text) {
    _onCommit(text);
  }
}
