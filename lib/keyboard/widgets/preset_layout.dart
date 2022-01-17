import 'dart:async';

import 'package:flime/api/api.dart';
import 'package:flime/input/core/event/event.dart';
import 'package:flime/input/core/event/event_extension.dart';
import 'package:flime/keyboard/api/apis.dart';
import 'package:flime/keyboard/basic/operations.dart';
import 'package:flime/keyboard/basic/preset.dart';
import 'package:flime/keyboard/services/input_service.dart';
import 'package:flime/keyboard/stores/input_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'key_inkwell.dart';

class PresetLayout extends StatelessWidget {
  final Preset preset;
  final void Function(KEvent) onKey;

  const PresetLayout({
    Key? key,
    required this.preset,
    required this.onKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Material(
      child: Column(
        children: [
          for (var r in preset)
            SizedBox(
              height: r.height,
              child: Row(
                children: [
                  for (var k in r)
                    KeyInkwell(
                      k: k,
                      width: width,
                      onKey: onKey,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

Future<void> onKey(
  KEvent event,
  BuildContext context, {
  required Function(Operation operation) onOperation,
}) async {
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
      if (event.click.isShift) {
        inputStatus.shifted = !inputStatus.shifted;
      } else {
        if (event.click.isBackspace) {
          unawaited(contextApi.delete());
        } else if (event.click.isEnter) {
          unawaited(contextApi.enter());
        } else if (event.click.isAlphabet) {
          final content = Content();
          if (!inputStatus.shifted) {
            content.text = event.click.keyLabel.toLowerCase();
            unawaited(contextApi.commit(content));
          } else {
            content.text = event.click.keyLabel;
            unawaited(contextApi.commit(content));
          }
        } else if (event.click.isNormalChar) {
          final content = Content()..text = event.click.keyLabel.toLowerCase();
          unawaited(contextApi.commit(content));
        }
        if (inputStatus.shifted) inputStatus.shifted = false;
      }
    } else if (event.type == EventType.operation) {
      onOperation(event.operation);
    }
  }
}
