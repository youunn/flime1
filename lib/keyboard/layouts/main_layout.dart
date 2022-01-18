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

  List<Widget> _buildCandidates(BuildContext context) {
    final inputStatus = context.read<InputStatus>();
    return <Widget>[
      Expanded(
        flex: 1,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 3, bottom: 3),
            child: ElevatedButton(
              child: Icon(
                Icons.chevron_left,
                color: Colors.grey.shade800,
                size: 18,
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const CircleBorder()),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
      Expanded(
        flex: 6,
        child: Row(
          children: <Widget>[
            for (final candidate
                in inputStatus.candidates.take(3).toList().asMap().entries)
              Expanded(
                child: InkWell(
                  child: Center(
                    child: Text(
                      candidate.value,
                      style: const TextStyle(
                        fontSize: 16,
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
              )
          ],
        ),
      ),
      Expanded(
        flex: 1,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 3, bottom: 3),
            child: TextButton(
              child: Icon(
                Icons.expand_more,
                color: Colors.grey.shade800,
                size: 18,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildOperations(BuildContext context) {
    return <Widget>[
      Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 3, bottom: 3),
            child: ElevatedButton(
              child: const Icon(
                Icons.chevron_right,
                color: Colors.black,
                size: 18,
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const CircleBorder()),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
      Expanded(
        child: _buildButton(
          context,
          iconData: Icons.g_translate,
          onPressed: () {},
        ),
      ),
      Expanded(
        child: _buildButton(
          context,
          iconData: Icons.keyboard_hide,
          onPressed: () {},
        ),
      ),
      Expanded(
        child: _buildButton(
          context,
          iconData: Icons.menu_open,
          onPressed: () {},
        ),
      ),
      Expanded(
        child: _buildButton(
          context,
          iconData: Icons.assignment,
          onPressed: () {},
        ),
      ),
      Expanded(
        child: _buildButton(
          context,
          iconData: Icons.settings,
          onPressed: () {},
        ),
      ),
      Expanded(
        child: _buildButton(
          context,
          iconData: Icons.more_horiz,
          onPressed: () {},
        ),
      ),
      Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 3, bottom: 3),
            child: TextButton(
              child: Icon(
                Icons.mic,
                color: Colors.grey.shade800,
                size: 18,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildButton(
    BuildContext context, {
    required IconData iconData,
    required void Function() onPressed,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 3, right: 3),
        child: TextButton(
          child: Icon(
            iconData,
            color: Colors.grey.shade800,
            size: 18,
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }

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
                builder: (_) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (inputStatus.isComposing)
                        ..._buildCandidates(context)
                      else
                        ..._buildOperations(context)
                    ],
                  );
                },
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
