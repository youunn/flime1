import 'package:flime/app/app.dart';
import 'package:flime/app/routing/route_state.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    return ListView(
      children: [
        ListTile(
          title: const Text('setup'),
          onTap: () {
            routeState.go(Pages.paths[Path.setup]!);
          },
        ),
        ListTile(
          title: const Text('input'),
          onTap: () {
            routeState.go(Pages.paths[Path.input]!);
          },
        )
      ],
    );
  }
}
