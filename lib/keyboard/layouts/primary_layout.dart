import 'package:flime/api/api.dart';
import 'package:flime/input/schemas/commands.dart';
import 'package:flime/keyboard/api/apis.dart';
import 'package:flime/input/core/event/event.dart';
import 'package:flime/input/core/event/event_extension.dart';
import 'package:flime/keyboard/basic/operations.dart';
import 'package:flime/keyboard/basic/preset.dart';
import 'package:flime/keyboard/stores/input_status.dart';
import 'package:flime/keyboard/widgets/preset_layout.dart';
import 'package:flime/keyboard/router/router.gr.dart';
import 'package:flime/keyboard/services/input_service.dart';
import 'package:flime/keyboard/widgets/preset_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PrimaryLayout extends StatelessWidget {
  final contextApi = Apis.contextApi;

  PrimaryLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PresetBuilder(
      child: PresetLayout(
        preset: PrimaryPreset.preset,
        onKey: (KEvent event) async {
          final inputStatus = context.read<InputStatus>();
          final service = context.read<InputService>();

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
              contextApi.commit(Content()..text = service.popCommitText());
            }
            if (event.type == EventType.click &&
                event.click == LogicalKeyboardKey.shift) {
              inputStatus.shifted = false;
            }
          } else {
            if (event.type == EventType.click) {
              if (event.click.isBackspace) {
                contextApi.delete();
              } else if (event.click.isEnter) {
                contextApi.enter();
              } else if (event.click.isShift) {
                inputStatus.shifted = !inputStatus.shifted;
              } else if (event.click.isAlphabet) {
                var content = Content();
                if (!inputStatus.shifted) {
                  content.text = event.click.keyLabel.toLowerCase();
                  contextApi.commit(content);
                } else {
                  content.text = event.click.keyLabel;
                  contextApi.commit(content);
                  inputStatus.shifted = false;
                }
              } else if (event.click.keyId >=
                      LogicalKeyboardKey.exclamation.keyId &&
                  event.click.keyId <= LogicalKeyboardKey.tilde.keyId) {
                var content = Content();
                content.text = event.click.keyLabel.toLowerCase();
                contextApi.commit(content);
              }
            } else if (event.type == EventType.operation) {
              switch (event.operation) {
                case Operation.switchLayout:
                  await Operations.switchLayout(
                    context,
                    const SecondaryRoute(),
                  );
                  break;
                default:
                  break;
              }
            }
          }
        },
      ),
    );
  }
}

typedef Ke = KEvent;
typedef Lk = LogicalKeyboardKey;

class PrimaryPreset {
  static final preset = Preset(
    width: 0.1,
    height: 76,
  )
    // 第一行
    ..r((r) => r
      ..c(Lk.keyQ)
      ..c(Lk.keyW)
      ..c(Lk.keyE)
      ..c(Lk.keyR)
      ..c(Lk.keyT)
      ..c(Lk.keyY)
      ..c(Lk.keyU)
      ..c(Lk.keyI)
      ..c(Lk.keyO)
      ..c(Lk.keyP))
    // 第二行
    ..r((r) => r
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
      ..c(Lk.keyL, label: '', width: 0.05))
    // 第三行
    ..r((r) => r
      ..c(Lk.shift, width: 0.15)
      ..c(Lk.keyZ)
      ..c(Lk.keyX)
      ..c(Lk.keyC)
      ..c(Lk.keyV)
      ..c(Lk.keyB)
      ..c(Lk.keyN)
      ..c(Lk.keyM)
      ..c(Lk.backspace, width: 0.15))
    // 第四行
    ..r(
      (r) => r
        ..k(Ke.operation(Operation.switchLayout), label: 'L2', width: 0.09)
        ..k(Ke.command(Commands.switchAsciiMode), label: 'ZH/EN', width: 0.09)
        ..c(Lk.comma, width: 0.18)
        ..c(Lk.space, width: 0.34)
        ..c(Lk.period, width: 0.14)
        ..c(Lk.enter, width: 0.16),
      height: 92,
    );
}
