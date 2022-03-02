import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class PresetBuilder extends StatelessWidget {
  final Widget child;

  const PresetBuilder({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, _) {
        final boxKey = GlobalKey();
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          final box = boxKey.currentContext!.findRenderObject() as RenderBox;
          final w = box.getMaxIntrinsicWidth(double.infinity);
          final h = box.getMaxIntrinsicHeight(w);
          final dpr = MediaQuery.of(context).devicePixelRatio;
          context.read<Constraint>().setHeightAndDpr(h, dpr);
        });

        return Container(
          clipBehavior: Clip.none,
          key: boxKey,
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: child,
          ),
        );
      },
    );
  }
}
