import 'package:flime/input/core/schema.dart';
import 'package:flime/input/schemas/processors/post/de_dup.dart';
import 'package:flime/input/schemas/processors/pre/editor.dart';
import 'package:flime/input/schemas/processors/pre/normal.dart';
import 'package:flime/input/schemas/processors/trans/default_table.dart';

class Schemas extends Schema {
  static Schema? _defaultSchema;

  static Future<Schema> getDefaultSchemaAsync() async =>
      // line break
      _defaultSchema ??= Schema(
        preFilters: [
          Editor(),
          NormalFilter(),
        ],
        translators: [
          await DefaultTableTranslator.createIfNotExistsAsync(),
        ],
        postFilters: [
          DeDupFilter(),
        ],
      );
}
