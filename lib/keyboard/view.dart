import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flime/keyboard/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeyboardView extends StatelessWidget {
  KeyboardView({Key? key}) : super(key: key);
  final _keyboardRouter = KeyboardRouter();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => Constraint()..setupReactions(),
      child: MaterialApp.router(
        routerDelegate: _keyboardRouter.delegate(),
        routeInformationParser: _keyboardRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
