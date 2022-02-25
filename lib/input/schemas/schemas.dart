import 'package:flime/input/core/schema.dart';
import 'package:flime/input/schemas/processors/post/de_dup.dart';
import 'package:flime/input/schemas/processors/post/opencc.dart';
import 'package:flime/input/schemas/processors/pre/command.dart';
import 'package:flime/input/schemas/processors/pre/editor.dart';
import 'package:flime/input/schemas/processors/pre/normal.dart';
import 'package:flime/input/schemas/processors/pre/symbol.dart';
import 'package:flime/input/schemas/processors/trans/default_table.dart';

Schema? _defaultSchema;

Future<Schema> getDefaultSchemaAsync() async =>
    // line break
    _defaultSchema ??= Schema(
      preFilters: [
        CommandFilter(),
        Editor(),
        NormalFilter(),
        SymbolFilter(),
      ],
      translators: [
        await DefaultTableTranslator.createIfNotExistsAsync(),
      ],
      postFilters: [
        await OpenCCFilter.createAsync(),
        DeDupFilter(),
      ],
    );
