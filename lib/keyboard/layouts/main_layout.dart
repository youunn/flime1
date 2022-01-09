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
        // TODO: fix not shown if not reload
        return SizedBox(
          height: constraint.height,
          child: child,
        );
      },
      child: const AutoRouter(),
    );
  }
}