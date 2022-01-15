import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

class Dictionary {
  Database? _database;
  late String _tableName;
  late String _codeColumn;
  late String _wordColumn;
  late String _indexColumn;
  bool _initialized = false;
  final _lock = Lock();

  Future<void> initFromAssets(
    String path, {
    required String table,
    required String code,
    required String word,
    required String index,
  }) async {
    await _lock.synchronized(() async {
      if (!_initialized) {
        final exists =
            await databaseExists(join(await getDatabasesPath(), path));
        if (!exists) {
          if (Platform.isAndroid) {
            await Directory(dirname(path)).create(recursive: true);

            final data = await rootBundle.load(join('assets', path));
            final bytes =
                data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

            await File(join(await getDatabasesPath(), path))
                .writeAsBytes(bytes, flush: true);
          } else {
            // do nothing yet
          }
        }
        _tableName = table;
        _codeColumn = code;
        _wordColumn = word;
        _indexColumn = index;
        _database = await openDatabase(path, readOnly: true);
        _initialized = true;
        await _database!.rawQuery('PRAGMA case_sensitive_like = ON');
      }
    });
  }

  bool get initialized => _initialized;

  Future<List<Entry>> getList(String code) async {
    final results = (await _database?.query(
          _tableName,
          columns: [_codeColumn, _wordColumn, _indexColumn],
          where: '$_codeColumn = ?',
          whereArgs: [code],
          limit: 100,
        ))
            ?.map(
              (e) => Entry(
                code: e[_codeColumn] as String,
                word: e[_wordColumn] as String,
                index: e[_indexColumn] as int,
              ),
            )
            .toList() ??
        [];
    return results..sort(Entry.compare);
  }

  Future<List<Entry>> getAll(String code, int count) async {
    final results = (await _database?.query(
          _tableName,
          columns: [_codeColumn, _wordColumn, _indexColumn],
          where: '$_codeColumn like ? || \'%\'',
          whereArgs: [code],
          limit: 100,
        ))
            ?.map(
              (e) => Entry(
                code: e[_codeColumn] as String,
                word: e[_wordColumn] as String,
                index: e[_indexColumn] as int,
              ),
            )
            .toList() ??
        [];

    return results..sort(Entry.compare);
  }
}

class Entry {
  final String code;
  final String word;
  final int index;

  Entry({
    required this.code,
    required this.word,
    required this.index,
  });

  static int compare(Entry a, Entry b) {
    final r1 = a.code.length.compareTo(b.code.length);
    if (r1 != 0) {
      return r1;
    } else {
      return a.index.compareTo(b.index);
    }
  }
}
