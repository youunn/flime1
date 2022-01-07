import 'package:auto_route/auto_route.dart';
import 'package:flime/api/api.dart';
import 'package:flime/keyboard/basic/preset.dart';
import 'package:flime/keyboard/router/router.gr.dart';
import 'package:flutter/material.dart';

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
                        if (k.special == Special.backspace) {
                          contextApi.delete();
                        } else if (k.special == Special.enter) {
                          context.router.replace(const SecondaryRoute());
                        } else {
                          var content = Content();
                          content.text = k.click;
                          contextApi.commit(content);
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
