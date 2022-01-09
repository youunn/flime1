import 'package:flime/input/core/dictionary.dart';
import 'package:flime/input/core/processors/translator.dart';

class DefaultTableTranslator extends Translator {
  final Dictionary _dictionary;

  DefaultTableTranslator() : _dictionary = Dictionary() {
    _dictionary.initFromAssets(
      'dict.db',
      table: 'entry',
      code: 'code',
      word: 'word',
      index: 'priority',
    );
  }

  @override
  Future<List<String>> process(String input) async {
    return (await _dictionary.getAll(input, 3)).map((e) => e.word).toList();
  }
}
