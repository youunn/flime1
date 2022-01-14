import 'package:flime/input/core/event/event.dart';
import 'package:flime/keyboard/basic/preset.dart';
import 'package:flutter/material.dart';

Widget buildFromPreset(
  BuildContext context,
  Preset preset, {
  required void Function(KEvent) onKey,
}) {
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
                  SizedBox(
                    width: width * k.width,
                    child: InkWell(
                      // 暂时只处理单击
                      onTap: () {
                        onKey(k.click);
                      },
                      child: Center(
                        child: Text(k.label),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    ),
  );
}
