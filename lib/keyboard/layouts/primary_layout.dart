import 'package:flime/keyboard/basic/preset.dart';
import 'package:flime/keyboard/layouts/widgets.dart';
import 'package:flime/keyboard/widgets/preset_builder.dart';
import 'package:flutter/material.dart';

class PrimaryLayout extends StatelessWidget {
  const PrimaryLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PresetBuilder(
      child: buildFromPreset(context, PrimaryPreset.preset),
    );
  }
}

class PrimaryPreset {
  static final preset = Preset(
    width: 0.1,
    height: 38,
  )
    // 第一行
    ..r((r) => r
      ..k('q')
      ..k('w')
      ..k('e')
      ..k('r')
      ..k('t')
      ..k('y')
      ..k('u')
      ..k('i')
      ..k('o')
      ..k('p'))
    // 第二行
    ..r((r) => r
      ..k('', click: 'a', width: 0.05)
      ..k('a')
      ..k('s')
      ..k('d')
      ..k('f')
      ..k('g')
      ..k('h')
      ..k('j')
      ..k('k')
      ..k('l')
      ..k('', click: 'l', width: 0.05))
    // 第三行
    ..r((r) => r
      ..k('S', width: 0.15)
      ..k('z')
      ..k('x')
      ..k('c')
      ..k('v')
      ..k('b')
      ..k('n')
      ..k('m')
      ..k('B', width: 0.15, special: Special.backspace))
    // 第四行
    ..r(
      (r) => r
        ..k('1', width: 0.18)
        ..k(',', width: 0.18)
        ..k(' ', width: 0.34)
        ..k('.', width: 0.14)
        ..k('E', width: 0.16, special: Special.enter),
      height: 46,
    );
}
