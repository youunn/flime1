import 'package:flime/input/core/event/event.dart';
import 'package:flime/input/schemas/commands.dart';
import 'package:flime/keyboard/basic/highlights.dart';
import 'package:flime/keyboard/basic/operations.dart';
import 'package:flime/keyboard/basic/preset.dart';
import 'package:flime/keyboard/widgets/preset_builder.dart';
import 'package:flime/keyboard/widgets/preset_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef Ke = KEvent;
typedef Lk = LogicalKeyboardKey;
typedef Sa = SingleActivator;

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
          onOperation: onDefaultOperation,
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
    height: 63,
    fontSize: 26,
  )
    ..r(
      // 第一行
      (r) => r
        ..c(Lk.keyQ, longClick: Ke.click(Lk.digit1))
        ..c(Lk.keyW, longClick: Ke.click(Lk.digit2))
        ..c(Lk.keyE, longClick: Ke.click(Lk.digit3))
        ..c(Lk.keyR, longClick: Ke.click(Lk.digit4))
        ..c(Lk.keyT, longClick: Ke.click(Lk.digit5))
        ..c(Lk.keyY, longClick: Ke.click(Lk.digit6))
        ..c(Lk.keyU, longClick: Ke.click(Lk.digit7))
        ..c(Lk.keyI, longClick: Ke.click(Lk.digit8))
        ..c(Lk.keyO, longClick: Ke.click(Lk.digit9))
        ..c(Lk.keyP, longClick: Ke.click(Lk.digit0)),
      firstRow: true,
    )
    ..r(
      // 第二行
      (r) => r
        ..c(
          Lk.keyA,
          longClick: Ke.click(Lk.exclamation),
          label: '',
          width: 0.05,
        )
        ..c(Lk.keyA, longClick: Ke.click(Lk.exclamation))
        ..c(Lk.keyS, longClick: Ke.click(Lk.minus))
        ..c(Lk.keyD, longClick: Ke.click(Lk.underscore))
        ..c(Lk.keyF, longClick: Ke.click(Lk.equal))
        ..c(Lk.keyG, longClick: Ke.click(Lk.add))
        ..c(Lk.keyH, longClick: Ke.click(Lk.quoteSingle))
        ..c(Lk.keyJ, longClick: Ke.click(Lk.quote))
        ..c(Lk.keyK, longClick: Ke.click(Lk.semicolon))
        ..c(Lk.keyL, longClick: Ke.click(Lk.colon))
        ..c(
          Lk.keyL,
          longClick: Ke.click(Lk.colon),
          label: '',
          width: 0.05,
        ),
    )
    ..r(
      // 第三行
      (r) => r
        ..c(Lk.shift, iconData: Icons.keyboard_capslock_outlined, width: 0.15)
        ..c(Lk.keyZ, longClick: Ke.combo(const Sa(Lk.keyA, control: true)))
        ..c(Lk.keyX, longClick: Ke.combo(const Sa(Lk.keyX, control: true)))
        ..c(Lk.keyC, longClick: Ke.combo(const Sa(Lk.keyC, control: true)))
        ..c(Lk.keyV, longClick: Ke.combo(const Sa(Lk.keyV, control: true)))
        ..c(Lk.keyB, longClick: Ke.click(Lk.backslash))
        ..c(Lk.keyN, longClick: Ke.click(Lk.question))
        ..c(Lk.keyM, longClick: Ke.click(Lk.slash))
        ..c(
          Lk.backspace,
          label: 'Bs',
          iconData: Icons.backspace_outlined,
          width: 0.15,
          repeatable: true,
        ),
    )
    ..r(
      // 第四行
      (r) => r
        ..k(
          Ke.operation(Operation.switchSecondaryLayout),
          longClick: Ke.operation(Operation.switchNumberLayout),
          composing: Ke.click(LogicalKeyboardKey.digit3),
          label: 'L2',
          // TODO: replace with onetwothree after flutter 2.10
          iconData: Icons.pin_outlined,
          width: 0.18,
        )
        ..c(
          Lk.comma,
          composing: Ke.click(LogicalKeyboardKey.digit2),
          width: 0.18,
        )
        ..c(
          Lk.space,
          longClick: Ke.command(switchAsciiMode),
          width: 0.34,
          highlight: Highlight.space,
        )
        ..c(
          Lk.period,
          composing: Ke.click(LogicalKeyboardKey.digit3),
          width: 0.14,
        )
        ..c(
          Lk.enter,
          iconData: Icons.keyboard_return_outlined,
          highlight: Highlight.enter,
          width: 0.16,
        ),
      height: 75,
    );
}
