import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flime/api/api.dart';
import 'package:flime/input/core/event/event.dart';
import 'package:flime/keyboard/api/apis.dart';
import 'package:flime/keyboard/services/input_service.dart';
import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flime/keyboard/stores/input_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final constraint = context.read<Constraint>();
    final inputStatus = context.read<InputStatus>();

    return Container(
      height: constraint.height,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: constraint.baseHeight,
            child: Material(
              child: Observer(
                builder: (_) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (final candidate in inputStatus.candidates
                        .take(3)
                        .toList()
                        .asMap()
                        .entries)
                      Expanded(
                        child: InkWell(
                          child: Center(
                            child: Text(
                              candidate.value,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          onTap: () async {
                            LogicalKeyboardKey? k;
                            switch (candidate.key) {
                              case 0:
                                k = LogicalKeyboardKey.digit1;
                                break;
                              case 1:
                                k = LogicalKeyboardKey.digit2;
                                break;
                              case 2:
                                k = LogicalKeyboardKey.digit3;
                                break;
                            }
                            if (k != null) {
                              final service = context.read<InputService>();
                              if (await service.onKey(KEvent.click(k))) {
                                if (service.commitText != '') {
                                  unawaited(
                                    scopedContextApi.commit(
                                      Content()..text = service.popCommitText(),
                                    ),
                                  );
                                }
                              }
                            }
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: AutoRouter(),
          ),
        ],
      ),
    );
  }
}
