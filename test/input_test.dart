import 'dart:io';

import 'package:flime/input/schemas/default_schema.dart';
import 'package:flime/input/service.dart';
import 'package:flime/keyboard/basic/event.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  group('Input service', () {
    setUpAll(() async {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;

      TestWidgetsFlutterBinding.ensureInitialized();

      var fileName = 'dict.db';
      var path = join((await getDatabasesPath()), fileName);
      await Directory(dirname(path)).create(recursive: true);
      List<int> bytes = await File(join('assets', fileName)).readAsBytes();
      await File(path).writeAsBytes(bytes, flush: true);
    });
    test('Engine initialization', () async {
      var service = Service();
      service.engine.schema = await Schemas.getDefaultSchemaAsync();
    });
    test('Basic input', () async {
      var service = Service();
      service.engine.schema = await Schemas.getDefaultSchemaAsync();
      await service.onKey(KEvent.click(LogicalKeyboardKey.keyF));
      await service.onKey(KEvent.click(LogicalKeyboardKey.keyW));
      await service.onKey(KEvent.click(LogicalKeyboardKey.keyV));
      await service.onKey(KEvent.click(LogicalKeyboardKey.keyQ));
      var commitText = service.popCommitText();
      expect(commitText, '测试');
    });
  });
}
