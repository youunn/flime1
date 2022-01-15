import 'dart:async';

import 'package:flime/api/api.dart';
import 'package:flime/input/core/event/event.dart';
import 'package:flime/input/core/event/event_extension.dart';
import 'package:flime/input/schemas/commands.dart';
import 'package:flime/keyboard/api/apis.dart';
import 'package:flime/keyboard/basic/operations.dart';
import 'package:flime/keyboard/basic/preset.dart';
import 'package:flime/keyboard/router/router.gr.dart';
import 'package:flime/keyboard/services/input_service.dart';
import 'package:flime/keyboard/stores/input_status.dart';
import 'package:flime/keyboard/widgets/preset_builder.dart';
import 'package:flime/keyboard/widgets/preset_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

typedef Ke = KEvent;
typedef Lk = LogicalKeyboardKey;

class PrimaryLayout extends StatelessWidget {
  const PrimaryLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PresetBuilder(
      child: PresetLayout(
        preset: _preset,
        onKey: (event) => _onKey(event, context),
      ),
    );
  }

  static Future<void> _onKey(KEvent event, BuildContext context) async {
    final inputStatus = context.read<InputStatus>();
    final service = context.read<InputService>();
    final contextApi = scopedContextApi;

    bool result;
    if (inputStatus.shifted &&
        event.type == EventType.click &&
        event.click != LogicalKeyboardKey.shift) {
      result = await service.onKey(
        KEvent.combo(SingleActivator(event.click, shift: true)),
      );
    } else {
      result = await service.onKey(event);
    }
    if (result) {
      if (service.commitText != '') {
        unawaited(
          contextApi.commit(Content()..text = service.popCommitText()),
        );
      }
      if (event.type == EventType.click &&
          event.click == LogicalKeyboardKey.shift) {
        inputStatus.shifted = !inputStatus.shifted;
      }
    } else {
      if (event.type == EventType.click) {
        if (event.click.isBackspace) {
          unawaited(contextApi.delete());
        } else if (event.click.isEnter) {
          unawaited(contextApi.enter());
        } else if (event.click.isShift) {
          inputStatus.shifted = !inputStatus.shifted;
        } else if (event.click.isAlphabet) {
          final content = Content();
          if (!inputStatus.shifted) {
            content.text = event.click.keyLabel.toLowerCase();
            unawaited(contextApi.commit(content));
          } else {
            content.text = event.click.keyLabel;
            unawaited(contextApi.commit(content));
          }
        } else if (event.click.keyId >= LogicalKeyboardKey.exclamation.keyId &&
            event.click.keyId <= LogicalKeyboardKey.tilde.keyId) {
          final content = Content()..text = event.click.keyLabel.toLowerCase();
          unawaited(contextApi.commit(content));
        }
      } else if (event.type == EventType.operation) {
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
      }
    }
  }

  static final _preset = Preset(
    width: 0.1,
    height: 76,
  )
    ..r(
      // 第一行
      (r) => r
        ..c(Lk.keyQ)
        ..c(Lk.keyW)
        ..c(Lk.keyE)
        ..c(Lk.keyR)
        ..c(Lk.keyT)
        ..c(Lk.keyY)
        ..c(Lk.keyU)
        ..c(Lk.keyI)
        ..c(Lk.keyO)
        ..c(Lk.keyP),
    )
    ..r(
      // 第二行
      (r) => r
        ..c(Lk.keyA, label: '', width: 0.05)
        ..c(Lk.keyA)
        ..c(Lk.keyS)
        ..c(Lk.keyD)
        ..c(Lk.keyF)
        ..c(Lk.keyG)
        ..c(Lk.keyH)
        ..c(Lk.keyJ)
        ..c(Lk.keyK)
        ..c(Lk.keyL)
        ..c(Lk.keyL, label: '', width: 0.05),
    )
    ..r(
      // 第三行
      (r) => r
        ..c(Lk.shift, width: 0.15)
        ..c(Lk.keyZ)
        ..c(Lk.keyX)
        ..c(Lk.keyC)
        ..c(Lk.keyV)
        ..c(Lk.keyB)
        ..c(Lk.keyN)
        ..c(Lk.keyM)
        ..c(Lk.backspace, width: 0.15),
    )
    ..r(
      // 第四行
      (r) => r
        ..k(Ke.operation(Operation.switchLayout), label: 'L2', width: 0.09)
        ..k(Ke.command(switchAsciiMode), label: 'ZH/EN', width: 0.09)
        ..c(Lk.comma, width: 0.18)
        ..c(Lk.space, width: 0.34)
        ..c(Lk.period, width: 0.14)
        ..c(Lk.enter, width: 0.16),
      height: 92,
    );
}
