import 'package:flime/input/core/dictionary.dart';
import 'package:flime/input/core/processors/translator.dart';

class DefaultTableTranslator extends Translator {
  final Dictionary _dictionary;

  static DefaultTableTranslator? _translator;

  DefaultTableTranslator._() : _dictionary = Dictionary();

  factory DefaultTableTranslator() =>
      _translator ??= DefaultTableTranslator._();

  static Future<DefaultTableTranslator> createIfNotExists() async {
    if (_translator == null) {
      _translator = DefaultTableTranslator._();
      await _translator!._dictionary.initFromAssets(
        'dict.db',
        table: 'entry',
        code: 'code',
        word: 'word',
        index: 'priority',
      );
    }

    return _translator!;
  }

  @override
  Future<List<String>> process(String input) async {
    return (await _dictionary.getAll(input, 3)).map((e) => e.word).toList();
  }
}
