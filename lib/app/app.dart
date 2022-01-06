import 'package:flime/app/pages/navigator.dart';
import 'package:flime/app/routing/delegate.dart';
import 'package:flime/app/routing/parser.dart';
import 'package:flime/app/routing/route_state.dart';
import 'package:flutter/material.dart';

enum Path { home, setup, input }

class Pages {
  static final Map<Path, String> paths = {
    Path.home: '/home',
    Path.setup: '/setup',
    Path.input: '/input',
  };
}

class FlimeApp extends StatefulWidget {
  const FlimeApp({Key? key}) : super(key: key);

  @override
  _FlimeAppState createState() => _FlimeAppState();
}

class _FlimeAppState extends State<FlimeApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final RouteState _routeState;
  late final SimpleRouterDelegate _routerDelegate;
  late final TemplateRouteParser _routeParser;

  @override
  void initState() {
    _routeParser = TemplateRouteParser(
      allowedPaths: Pages.paths.values.toList(),
      initialRoute: Pages.paths[Path.home]!,
    );
    _routeState = RouteState(_routeParser);
    _routerDelegate = SimpleRouterDelegate(
      routeState: _routeState,
      navigatorKey: _navigatorKey,
      builder: (context) => FlimeNavigator(
        navigatorKey: _navigatorKey,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RouteStateScope(
      notifier: _routeState,
      child: MaterialApp.router(
        routeInformationParser: _routeParser,
        routerDelegate: _routerDelegate,
      ),
    );
  }

  @override
  void dispose() {
    _routeState.dispose();
    _routerDelegate.dispose();
    super.dispose();
  }
}
