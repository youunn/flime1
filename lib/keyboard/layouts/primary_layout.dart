import 'package:flime/input/core/event/event.dart';
import 'package:flime/input/schemas/commands.dart';
import 'package:flime/keyboard/basic/operations.dart';
import 'package:flime/keyboard/basic/preset.dart';
import 'package:flime/keyboard/router/router.gr.dart';
import 'package:flime/keyboard/widgets/preset_builder.dart';
import 'package:flime/keyboard/widgets/preset_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef Ke = KEvent;
typedef Lk = LogicalKeyboardKey;

class PrimaryLayout extends StatelessWidget {
  const PrimaryLayout({Key? key}) : super(key: key);

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
                  const SecondaryRoute(),
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

  // q w e r t y u i o p
  //  a s d f g h j k l
  //  S z x c v b n m B
  //  1 ,   . E
  //
  // 1 2 3 4 5 6 7 8 9 0
  //  ! _ - = + ' " ; :
  //    z x c v \ ? /
  static final _preset = Preset(
    width: 0.1,
    height: 76,
  )
    ..r(
      // 第一行
      (r) => r
        ..c(Lk.keyQ, longClick: KEvent.click(Lk.digit1))
        ..c(Lk.keyW, longClick: KEvent.click(Lk.digit2))
        ..c(Lk.keyE, longClick: KEvent.click(Lk.digit3))
        ..c(Lk.keyR, longClick: KEvent.click(Lk.digit4))
        ..c(Lk.keyT, longClick: KEvent.click(Lk.digit5))
        ..c(Lk.keyY, longClick: KEvent.click(Lk.digit6))
        ..c(Lk.keyU, longClick: KEvent.click(Lk.digit7))
        ..c(Lk.keyI, longClick: KEvent.click(Lk.digit8))
        ..c(Lk.keyO, longClick: KEvent.click(Lk.digit9))
        ..c(Lk.keyP, longClick: KEvent.click(Lk.digit0)),
    )
    ..r(
      // 第二行
      (r) => r
        ..c(
          Lk.keyA,
          longClick: KEvent.click(Lk.exclamation),
          label: '',
          width: 0.05,
        )
        ..c(Lk.keyA, longClick: KEvent.click(Lk.exclamation))
        ..c(Lk.keyS, longClick: KEvent.click(Lk.minus))
        ..c(Lk.keyD, longClick: KEvent.click(Lk.underscore))
        ..c(Lk.keyF, longClick: KEvent.click(Lk.equal))
        ..c(Lk.keyG, longClick: KEvent.click(Lk.add))
        ..c(Lk.keyH, longClick: KEvent.click(Lk.quoteSingle))
        ..c(Lk.keyJ, longClick: KEvent.click(Lk.quote))
        ..c(Lk.keyK, longClick: KEvent.click(Lk.semicolon))
        ..c(Lk.keyL, longClick: KEvent.click(Lk.colon))
        ..c(
          Lk.keyL,
          longClick: KEvent.click(Lk.colon),
          label: '',
          width: 0.05,
        ),
    )
    ..r(
      // 第三行
      (r) => r
        ..c(Lk.shift, width: 0.15)
        ..c(Lk.keyZ) // TODO: C-A
        ..c(Lk.keyX) // TODO: C-X
        ..c(Lk.keyC) // TODO: C-C
        ..c(Lk.keyV) // TODO: C-V
        ..c(Lk.keyB, longClick: KEvent.click(Lk.backslash))
        ..c(Lk.keyN, longClick: KEvent.click(Lk.question))
        ..c(Lk.keyM, longClick: KEvent.click(Lk.slash))
        ..c(Lk.backspace, label: 'Bs', width: 0.15, repeatable: true),
    )
    ..r(
      // 第四行
      (r) => r
        ..k(Ke.operation(Operation.switchLayout), label: 'L2', width: 0.18)
        ..c(
          Lk.comma,
          composing: KEvent.click(LogicalKeyboardKey.digit3),
          width: 0.18,
        )
        ..c(Lk.space, longClick: Ke.command(switchAsciiMode), width: 0.34)
        ..c(
          Lk.period,
          composing: KEvent.click(LogicalKeyboardKey.digit2),
          width: 0.14,
        )
        ..c(Lk.enter, width: 0.16),
      height: 92,
    );
}
