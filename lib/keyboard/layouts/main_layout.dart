import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final constraint = context.read<Constraint>();
    const routerWidget = Expanded(
      child: AutoRouter(),
    );

    return Observer(
      builder: (context) {
        return Container(
          height: constraint.height,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: constraint.baseHeight,
                child: const Center(
                  child: Text(
                    // TODO: candidates
                    'Candidates',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
              routerWidget,
            ],
          ),
        );
      },
    );
  }
}
