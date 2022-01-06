import 'package:flime/app/app.dart';
import 'package:flime/app/pages/home_page.dart';
import 'package:flime/app/pages/input_page.dart';
import 'package:flime/app/pages/setup_page.dart';
import 'package:flime/app/routing/route_state.dart';
import 'package:flutter/material.dart';

class FlimeNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const FlimeNavigator({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  _FlimeNavigatorState createState() => _FlimeNavigatorState();
}

class _FlimeNavigatorState extends State<FlimeNavigator> {
  final _homeKey = const ValueKey('home page');
  final _setupKey = const ValueKey('setup page');
  final _inputKey = const ValueKey('input page');

  @override
  Widget build(BuildContext context) {
    final path = RouteStateScope.of(context).route.path;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Flime'),
      ),
      body: Navigator(
        key: widget.navigatorKey,
        onPopPage: (route, dynamic result) {
          if (!route.didPop(result)) {
            return false;
          }
          // do something
          return true;
        },
        pages: [
          // TODO: back key to go back home page
          if (path == Pages.paths[Path.home])
            MaterialPage(key: _homeKey, child: const HomePage())
          else if (path == Pages.paths[Path.setup])
            MaterialPage(key: _setupKey, child: SetupPage())
          else if (path == Pages.paths[Path.input])
            MaterialPage(key: _inputKey, child: const InputPage())
          else
            MaterialPage(key: _homeKey, child: const HomePage())
        ],
      ),
    );
  }
}
