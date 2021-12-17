import 'package:flutter/material.dart';

import '../api/api.dart';

class KeyboardKey {
  String label;
  String click;
  bool delete;

  KeyboardKey(this.label, this.click, {this.delete = false});
}

typedef Kk = KeyboardKey;

class KeyboardLayout extends StatelessWidget {
  KeyboardLayout({Key? key}) : super(key: key);

  final contextApi = ContextApi();

  // TODO: dsl or from file
  final keys = <List<KeyboardKey>>[
    [
      Kk('Q', 'q'),
      Kk('W', 'w'),
      Kk('E', 'e'),
      Kk('R', 'r'),
      Kk('T', 't'),
      Kk('Y', 'y'),
      Kk('U', 'u'),
      Kk('I', 'i'),
      Kk('O', 'o'),
      Kk('P', 'p'),
    ],
    [
      Kk('A', 'a'),
      Kk('S', 's'),
      Kk('D', 'd'),
      Kk('F', 'f'),
      Kk('G', 'g'),
      Kk('H', 'h'),
      Kk('J', 'j'),
      Kk('K', 'k'),
      Kk('L', 'l'),
    ],
    [
      Kk(' ', ' '),
      Kk('Z', 'z'),
      Kk('X', 'x'),
      Kk('C', 'c'),
      Kk('V', 'v'),
      Kk('B', 'b'),
      Kk('N', 'n'),
      Kk('M', 'm'),
    ],
    [
      Kk(' ', ' '),
      Kk(' ', ' '),
      Kk(' ', ' '),
      Kk(' ', ' '),
      Kk(' ', ' '),
      Kk(' ', ' '),
      Kk(' ', ' '),
      Kk(' ', ' '),
      Kk(' ', ' '),
      Kk(' ', ' ', delete: true),
    ],
  ];

  Widget buildKey(KeyboardKey keyboardKey) {
    return ElevatedButton(
      child: Text(keyboardKey.label),
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 13),
      ),
      onPressed: () {
        if (!keyboardKey.delete) {
          var content = Content();
          content.text = keyboardKey.click;
          contextApi.commit(content);
        } else {
          // TODO: Gesture detector
          contextApi.delete();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (var row in keys)
          Row(
            children: [
              for (var k in row)
                Expanded(
                  flex: 1,
                  child: buildKey(k),
                ),
            ],
          ),
      ],
    );
  }
}
