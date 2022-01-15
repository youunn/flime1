import 'package:flime/input/core/event/event.dart';
import 'package:flime/input/core/processors/pre_filter.dart';

import 'context.dart';
import 'schema.dart';

class Engine {
  Schema _schema;
  final Context _context;
  late void Function(String) _onCommit;

  Engine()
      : _schema = Schema(),
        _context = Context() {
    _context
      ..onChange = compose
      ..onCommit = commit;
  }

  Context get context => _context;

  set schema(Schema value) => _schema = value;

  Future setSchemaAsync(Future<Schema> value) async => _schema = await value;

  set onCommit(void Function(String) value) => _onCommit = value;

  Enum? getOption(String s) => _schema.getOption(s);

  void setOption(String s, Enum value) => _schema.setOption(s, value);

  Future<bool> processKey(KEvent event) async {
    for (final preFilter in _schema.preFilters) {
      final result = await preFilter.process(this, event);
      switch (result) {
        case PreFilterResult.finish:
          return true;
        case PreFilterResult.denied:
          return false;
        case PreFilterResult.pass:
          break;
      }
    }

    return false;
  }

  Future compose() async {
    if (_context.input.isNotEmpty) {
      _context.candidates.clear();
      for (final translator in _schema.translators) {
        _context.candidates.addAll(await translator.process(_context.input));
      }
      for (final postFilter in _schema.postFilters) {
        final filtered = postFilter.process(_context.candidates);
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
