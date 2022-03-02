import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flime/api/api.dart';
import 'package:flime/input/core/event/event.dart';
import 'package:flime/input/schemas/commands.dart';
import 'package:flime/keyboard/api/apis.dart';
import 'package:flime/keyboard/router/router.gr.dart';
import 'package:flime/keyboard/services/input_service.dart';
import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flime/keyboard/stores/input_status.dart';
import 'package:flime/keyboard/stores/theme.dart';
import 'package:flime/keyboard/widgets/expand_more.dart';
import 'package:flime/keyboard/widgets/preset_layout.dart';
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
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: ElevatedButton(
              child: const Icon(
                Icons.chevron_left,
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
                      style: TextStyle(
                        fontSize: candidate.value.length <= 4
                            ? 20
                            : 80 / candidate.value.length,
                        color: context.read<KeyboardTheme>().darkMode
                            ? Colors.grey.shade300
                            : Colors.black,
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
                    if (context.router.isRouteActive(CandidatesRoute.name)) {
                      unawaited(context.router.replace(const PrimaryRoute()));
                    }
                  },
                ),
              )
          ],
        ),
      ),
      const Expanded(
        child: ExpandMore(),
      ),
    ];
  }

  List<Widget> _buildOperations(BuildContext context) {
    final darkMode = context.read<KeyboardTheme>().darkMode;

    return <Widget>[
      Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
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
          darkMode: darkMode,
          onPressed: () {
            context.read<InputService>().onKey(KEvent.command(switchAsciiMode));
          },
        ),
      ),
      Expanded(
        child: _buildButton(
          context,
          iconData: Icons.keyboard_hide,
          darkMode: darkMode,
          onPressed: () {
            scopedInputMethodApi.pick();
          },
        ),
      ),
      Expanded(
        child: _buildButton(
          context,
          iconData: Icons.menu_open,
          darkMode: darkMode,
          onPressed: () {
            onKey(
              KEvent.click(LogicalKeyboardKey.arrowLeft),
              context,
            );
          },
        ),
      ),
      Expanded(
        child: _buildButton(
          context,
          iconData: Icons.assignment,
          darkMode: darkMode,
          onPressed: () {
            onKey(
              KEvent.click(LogicalKeyboardKey.arrowRight),
              context,
            );
          },
        ),
      ),
      Expanded(
        child: _buildButton(
          context,
          iconData: Icons.settings,
          darkMode: darkMode,
          onPressed: () {
            context
                .read<InputService>()
                .onKey(KEvent.command(switchOpenCCOption));
          },
        ),
      ),
      Expanded(
        child: _buildButton(
          context,
          iconData: Icons.more_horiz,
          darkMode: darkMode,
          onPressed: () {
            context.read<InputService>().onKey(KEvent.command(switchAsciiMode));
          },
        ),
      ),
      Expanded(
        child: _buildButton(
          context,
          iconData: Icons.mic,
          darkMode: darkMode,
          onPressed: () {
            context
                .read<InputService>()
                .onKey(KEvent.command(resetOpenCCOption));
          },
        ),
      ),
    ];
  }

  Widget _buildButton(
    BuildContext context, {
    required IconData iconData,
    required void Function() onPressed,
    bool darkMode = true,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 3, right: 3),
        child: TextButton(
          child: Icon(
            iconData,
            color: darkMode ? Colors.grey.shade400 : Colors.grey.shade800,
            size: 18,
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            overlayColor: MaterialStateProperty.all(
              darkMode ? Colors.grey.shade700 : Colors.grey.shade300,
            ),
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
      clipBehavior: Clip.none,
      height: constraint.height,
      child: Column(
        children: [
          SizedBox(
            height: constraint.baseHeight,
            child: Material(
              color: context.read<KeyboardTheme>().darkMode
                  ? Colors.black
                  : Colors.white,
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
