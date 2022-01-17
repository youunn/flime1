import 'package:flime/input/core/event/event.dart';
import 'package:flime/keyboard/basic/operations.dart';
import 'package:flime/keyboard/basic/preset.dart';
import 'package:flime/keyboard/router/router.gr.dart';
import 'package:flime/keyboard/widgets/preset_builder.dart';
import 'package:flime/keyboard/widgets/preset_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef Ke = KEvent;
typedef Lk = LogicalKeyboardKey;

class SecondaryLayout extends StatelessWidget {
  const SecondaryLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PresetBuilder(
      child: PresetLayout(
        preset: _preset,
        onKey: (event) => onKey(
          event,
          context,
          onOperation: (operation) async {
            switch (event.operation) {
              case Operation.switchLayout:
                await switchLayout(
                  context,
                  const PrimaryRoute(),
                );
                break;
              default:
                break;
            }
          },
        ),
      ),
    );
  }

  // ! @ # $ % ^ & * ( )
  //  ` _ - = + ' " ; :
  //  ~ < > [ ] { } | B
  //    , . \ ? /     E
  static final _preset = Preset(
    width: 0.1,
    height: 76,
  )
    ..r(
      // 第一行
      (r) => r
        ..c(Lk.exclamation)
        ..c(Lk.at)
        ..c(Lk.numberSign)
        ..c(Lk.dollar)
        ..c(Lk.percent)
        ..c(Lk.caret)
        ..c(Lk.ampersand)
        ..c(Lk.asterisk)
        ..c(Lk.parenthesisLeft)
        ..c(Lk.parenthesisRight),
    )
    ..r(
      // 第二行
      (r) => r
        ..c(Lk.backquote, label: '', width: 0.05)
        ..c(Lk.backquote)
        ..c(Lk.minus)
        ..c(Lk.underscore)
        ..c(Lk.equal)
        ..c(Lk.add)
        ..c(Lk.quoteSingle)
        ..c(Lk.quote)
        ..c(Lk.semicolon)
        ..c(Lk.colon)
        ..c(Lk.colon, label: '', width: 0.05),
    )
    ..r(
      // 第三行
      (r) => r
        ..c(Lk.tilde, width: 0.15)
        ..c(Lk.less)
        ..c(Lk.greater)
        ..c(Lk.bracketLeft)
        ..c(Lk.bracketRight)
        ..c(Lk.braceLeft)
        ..c(Lk.braceRight)
        ..c(Lk.bar)
        ..c(Lk.backspace, label: 'Bs', width: 0.15, repeatable: true),
    )
    ..r(
      // 第四行
      (r) => r
        ..k(Ke.operation(Operation.switchLayout), label: 'L1', width: 0.18)
        ..c(Lk.comma)
        ..c(Lk.period)
        ..c(Lk.backslash)
        ..c(Lk.question)
        ..c(Lk.slash)
        ..c(Lk.space, width: 0.16)
        ..c(Lk.enter, width: 0.16),
      height: 92,
    );
}
