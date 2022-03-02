import 'package:flime/input/core/event/event.dart';
import 'package:flime/keyboard/basic/highlights.dart';
import 'package:flime/keyboard/basic/operations.dart';
import 'package:flime/keyboard/basic/preset.dart';
import 'package:flime/keyboard/widgets/preset_builder.dart';
import 'package:flime/keyboard/widgets/preset_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef Ke = KEvent;
typedef Lk = LogicalKeyboardKey;

class NumberLayout extends StatelessWidget {
  const NumberLayout({Key? key}) : super(key: key);

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

  static final _preset = Preset(
    width: 0.23,
    height: 63,
    fontSize: 26,
  )
    ..r(
      (r) => r
        ..c(Lk.add, width: 0.15)
        ..c(Lk.digit1)
        ..c(Lk.digit2)
        ..c(Lk.digit3)
        ..c(Lk.slash, width: 0.16),
      firstRow: true,
    )
    ..r(
      (r) => r
        ..c(Lk.minus, width: 0.15)
        ..c(Lk.digit4)
        ..c(Lk.digit5)
        ..c(Lk.digit6)
        ..c(
          Lk.space,
          label: ' ',
          iconData: Icons.space_bar,
          width: 0.16,
          repeatable: true,
        ),
    )
    ..r(
      (r) => r
        ..c(Lk.asterisk, width: 0.15)
        ..c(Lk.digit7)
        ..c(Lk.digit8)
        ..c(Lk.digit9)
        ..c(
          Lk.backspace,
          label: 'Bs',
          iconData: Icons.backspace_outlined,
          width: 0.16,
          repeatable: true,
        ),
    )
    ..r(
      (r) => r
        ..k(
          Ke.operation(Operation.switchPrimaryLayout),
          label: 'L1',
          iconData: Icons.skip_previous_outlined,
          width: 0.15,
        )
        ..k(
          Ke.operation(Operation.switchSecondaryLayout),
          label: 'L2',
          iconData: Icons.skip_next_outlined,
        )
        ..c(Lk.digit0)
        ..c(Lk.equal)
        ..c(
          Lk.enter,
          iconData: Icons.keyboard_return_outlined,
          highlight: Highlight.enter,
          width: 0.16,
        ),
      height: 75,
    );
}
