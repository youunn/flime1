import 'package:auto_route/auto_route.dart';
import 'package:flime/api/api.dart';
import 'package:flime/keyboard/basic/event.dart';
import 'package:flime/keyboard/basic/event_extension.dart';
import 'package:flime/keyboard/basic/preset.dart';
import 'package:flime/keyboard/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildFromPreset(BuildContext context, Preset preset) {
  final contextApi = ContextApi();
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
                      onTap: () {
                        // 事件处理青春版
                        if (k.click.type == EventType.click) {
                          if (k.click.click.isBackspace) {
                            contextApi.delete();
                          } else if (k.click.click.isEnter) {
                            contextApi.enter();
                          } else if (k.click.click.keyId >=
                                  LogicalKeyboardKey.exclamation.keyId &&
                              k.click.click.keyId <=
                                  LogicalKeyboardKey.tilde.keyId) {
                            var content = Content();
                            content.text = k.click.click.keyLabel;
                            contextApi.commit(content);
                          }
                        } else if (k.click.type == EventType.command) {
                          context.router.replace(const SecondaryRoute());
                        }
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
