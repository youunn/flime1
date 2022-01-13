import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flime/keyboard/stores/input_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final constraint = context.read<Constraint>();

    return Consumer<InputStatus>(
      builder: (context, inputStatus, child) => Observer(
        builder: (context) {
          return Container(
            height: constraint.height,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: constraint.baseHeight,
                  child: Center(
                    child: Text(
                      inputStatus.candidates.take(3).toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                if (child != null) child,
              ],
            ),
          );
        },
      ),
      child: const Expanded(
        child: AutoRouter(),
      ),
    );
  }
}
