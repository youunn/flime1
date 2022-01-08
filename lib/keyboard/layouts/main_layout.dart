import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/providers/constraint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Constraint>(
      builder: (context, constraint, child) {
        return SizedBox(
          height: constraint.height,
          child: SizedBox.expand(
            child: child,
          ),
        );
      },
      child: const AutoRouter(),
    );
  }
}
