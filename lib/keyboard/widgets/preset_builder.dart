import 'package:flime/keyboard/providers/constraint.dart';
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
        var boxKey = GlobalKey();
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          RenderBox box =
              boxKey.currentContext!.findRenderObject() as RenderBox;
          var w = box.getMaxIntrinsicWidth(double.infinity);
          var h = box.getMaxIntrinsicHeight(w);
          var dpr = MediaQuery.of(context).devicePixelRatio;

          var constraint = context.read<Constraint>();
          constraint.dpr = dpr;
          constraint.height = h;
        });

        return Container(
          key: boxKey,
          child: SingleChildScrollView(
            child: child,
          ),
        );
      },
    );
  }
}
