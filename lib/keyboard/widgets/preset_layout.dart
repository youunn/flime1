import 'package:flime/input/core/event/event.dart';
import 'package:flime/keyboard/basic/preset.dart';
import 'package:flutter/material.dart';

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
