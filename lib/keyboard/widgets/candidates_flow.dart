import 'package:auto_route/auto_route.dart';
import 'package:flime/api/api.dart';
import 'package:flime/keyboard/api/apis.dart';
import 'package:flime/keyboard/router/router.gr.dart';
import 'package:flime/keyboard/services/input_service.dart';
import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flime/keyboard/stores/input_status.dart';
import 'package:flime/keyboard/stores/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CandidatesFlow extends StatelessWidget {
  const CandidatesFlow({Key? key, required this.candidates}) : super(key: key);

  final List<String> candidates;

  @override
  Widget build(BuildContext context) {
    final constraint = context.read<Constraint>();

    // TODO: Flow or render object
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: constraint.height,
      ),
      child: Wrap(
        children: [
          for (var candidate in candidates.asMap().entries)
            InkWell(
              child: SizedBox(
                width: 32 * candidate.value.length.toDouble(),
                height: 36,
                child: Center(
                  child: Text(
                    candidate.value,
                    style: TextStyle(
                      fontSize: 16,
                      color: context.read<KeyboardTheme>().darkMode
                          ? Colors.grey.shade300
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              onTap: () async {
                final service = context.read<InputService>();
                await service.engine.context.commitAt(candidate.key + 3);
                if (service.commitText != '') {
                  await scopedContextApi.commit(
                    Content()..text = service.popCommitText(),
                  );
                }
                context.read<InputStatus>().update();
                await context.router.replace(const PrimaryRoute());
              },
            ),
        ],
      ),
    );
  }
}
