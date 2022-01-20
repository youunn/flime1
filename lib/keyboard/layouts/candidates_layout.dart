import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flime/keyboard/stores/input_status.dart';
import 'package:flime/keyboard/stores/theme.dart';
import 'package:flime/keyboard/widgets/candidates_flow.dart';
import 'package:flime/keyboard/widgets/preset_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CandidatesLayout extends StatelessWidget {
  const CandidatesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputStatus = context.read<InputStatus>();
    final constraint = context.read<Constraint>();

    return PresetBuilder(
      child: SizedBox(
        height: constraint.height,
        child: Material(
          color: context.read<KeyboardTheme>().darkMode
              ? Colors.black
              : Colors.white,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraint.height,
                    ),
                    child: Column(
                      children: [
                        for (var c in inputStatus.input.characters)
                          SizedBox(
                            height: constraint.height / 6,
                            child: Center(
                              child: Text(
                                c,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: context.read<KeyboardTheme>().darkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: inputStatus.candidates.length > 3
                    ? SingleChildScrollView(
                        child: CandidatesFlow(
                          candidates: inputStatus.candidates.sublist(3),
                        ),
                      )
                    : const SizedBox(),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
