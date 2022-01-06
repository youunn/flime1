import 'package:flime/app/routing/parsed_route.dart';
import 'package:flime/app/routing/parser.dart';
import 'package:flutter/widgets.dart';

class RouteState extends ChangeNotifier {
  final TemplateRouteParser _parser;
  ParsedRoute _route;

  RouteState(this._parser) : _route = _parser.initialRoute;

  ParsedRoute get route => _route;

  set route(ParsedRoute route) {
    if (_route == route) return;
    _route = route;
    notifyListeners();
  }

  Future go(String route) async {
    this.route =
        await _parser.parseRouteInformation(RouteInformation(location: route));
  }
}

class RouteStateScope extends InheritedNotifier<RouteState> {
  const RouteStateScope({
    required RouteState notifier,
    required Widget child,
    Key? key,
  }) : super(key: key, notifier: notifier, child: child);

  static RouteState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<RouteStateScope>()!.notifier!;
}
