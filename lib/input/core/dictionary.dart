import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dictionary {
  Database? _database;
  late String tableName;
  late String codeColumn;
  late String wordColumn;
  late String indexColumn;

  Future<void> initFromAssets(
    String path, {
    required String table,
    required String code,
    required String word,
    required String index,
  }) async {
    var exists = await databaseExists(join((await getDatabasesPath()), path));
    if (!exists) {
      await Directory(dirname(path)).create(recursive: true);

      ByteData data = await rootBundle.load(join('assets', path));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(join((await getDatabasesPath()), path))
          .writeAsBytes(bytes, flush: true);
    }
    tableName = table;
    codeColumn = code;
    wordColumn = word;
    indexColumn = index;
    _database = await openDatabase(path, readOnly: true);
  }

  bool get isInitialized => _database != null;

  Future<List<Entry>> getList(String code) async {
    var results = (await _database?.query(
          tableName,
          columns: [codeColumn, wordColumn, indexColumn],
          where: '$codeColumn = ?',
          whereArgs: [code],
          limit: 100,
        ))
            ?.map((e) => Entry(
                  code: e[codeColumn] as String,
                  word: e[wordColumn] as String,
                  index: e[indexColumn] as int,
                ))
            .toList() ??
        [];
    return results..sort(Entry.compare);
  }

  Future<List<Entry>> getAll(String code, int count) async {
    var results = (await _database?.query(
          tableName,
          columns: [codeColumn, wordColumn, indexColumn],
          where: '$codeColumn like ? || \'%\'',
          whereArgs: [code],
          limit: 100,
        ))
            ?.map((e) => Entry(
                  code: e[codeColumn] as String,
                  word: e[wordColumn] as String,
                  index: e[indexColumn] as int,
                ))
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
    var r1 = a.code.length.compareTo(b.code.length);
    if (r1 != 0) {
      return r1;
    } else {
      return a.index.compareTo(b.index);
    }
  }
}
