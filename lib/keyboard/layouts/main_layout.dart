import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/models/constraint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Constraint>(
      builder: (context, constraint, child) {
        return Container(
          height: constraint.height,
          color: Colors.white,
          child: child,
        );
      },
      child: Column(
        children: [
          SizedBox(
            height: context.read<Constraint>().baseHeight,
            child: const Center(
              child: Text(
                // TODO: candidates
                'Candidates',
                style: TextStyle(fontSize: 10),
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
