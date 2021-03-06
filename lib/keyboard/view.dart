import 'package:flime/input/schemas/schemas.dart';
import 'package:flime/keyboard/router/router.gr.dart';
import 'package:flime/keyboard/services/input_service.dart';
import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flime/keyboard/stores/input_status.dart';
import 'package:flime/keyboard/stores/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeyboardView extends StatelessWidget {
  KeyboardView({Key? key}) : super(key: key);
  final _keyboardRouter = KeyboardRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Constraint>(
          create: (_) => Constraint()..setupReactions(),
        ),
        Provider<KeyboardTheme>(
          create: (_) => KeyboardTheme(),
        ),
        Provider<InputService>(
          create: (_) =>
              InputService()..engine.setSchemaAsync(getDefaultSchemaAsync()),
        ),
        ProxyProvider<InputService, InputStatus>(
          update: (_, service, __) => InputStatus(service),
        ),
      ],
      child: MaterialApp.router(
        routerDelegate: _keyboardRouter.delegate(),
        routeInformationParser: _keyboardRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
