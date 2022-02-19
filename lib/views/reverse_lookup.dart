import 'package:flime/api/api.dart';
import 'package:flime/input/core/dictionary.dart';
import 'package:flutter/material.dart';

class ReverseLookupView extends StatelessWidget {
  const ReverseLookupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SizedBox.expand(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: FutureBuilder<String>(
                future: ProcessTextApi().getText(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return FutureBuilder<List<String>>(
                      future: query(snapshot.data ?? ''),
                      builder: (context, querySnapshot) {
                        if (querySnapshot.hasData &&
                            querySnapshot.data != null) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var line in querySnapshot.data!) Text(line)
                            ],
                          );
                        } else {
                          return Text(snapshot.data ?? '');
                        }
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final _dictionary = Dictionary();

Future<Dictionary> _getDictionary() async {
  if (!_dictionary.initialized) {
    await _dictionary.initFromAssets(
      'dict.db',
      table: 'entry',
      code: 'code',
      word: 'word',
      index: 'priority',
    );
  }
  return _dictionary;
}

Future<List<String>> query(String word) async {
  if (word.isEmpty) return [];
  if (word.length == 1) {
    final queryResult = await (await _getDictionary()).query(word);
    if (queryResult.isEmpty) return ['$word: 无'];
    final result = queryResult.map((e) => e.code).join(', ');
    return ['$word: $result'];
  }

  final results = <String>[];
  final queryResult = await (await _getDictionary()).query(word);
  if (queryResult.isNotEmpty) {
    final result = queryResult.map((e) => e.code).join(', ');
    results.add('$word: $result');
  } else {
    results.add(word);
  }

  for (final char in word.characters) {
    final queryResult = await (await _getDictionary()).query(char);
    if (queryResult.isNotEmpty) {
      final result = queryResult.map((e) => e.code).join(', ');
      results.add('$char: $result');
    } else {
      results.add('$char: 无');
    }
  }

  return results;
}
