import 'package:flime/input/core/engine.dart';
import 'package:flime/input/core/schema.dart';
import 'package:flime/input/schemas/processors/post/de_dup.dart';
import 'package:flime/input/schemas/processors/pre/editor.dart';
import 'package:flime/input/schemas/processors/pre/normal.dart';
import 'package:flime/input/schemas/processors/trans/default_table.dart';

class Schemas extends Schema {
  static final defaultSchema = Schema(
    preFilters: [
      Editor(_engine),
      NormalFilter(_engine),
    ],
    translators: [
      DefaultTableTranslator(),
    ],
    postFilters: [
      DeDupFilter(),
    ],
  );

  static late Engine _engine;

  static set engine(Engine value) {
    _engine = value;
  }
}
