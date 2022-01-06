import 'package:flime/app/routing/parsed_route.dart';
import 'package:flime/app/routing/route_state.dart';
import 'package:flutter/widgets.dart';

class TemplateRouteParser extends RouteInformationParser<ParsedRoute> {
  final List<String> _pathTemplates;
  final ParsedRoute initialRoute;

  TemplateRouteParser({
    required List<String> allowedPaths,
    String initialRoute = '/',
  })  : initialRoute = ParsedRoute(initialRoute),
        _pathTemplates = [...allowedPaths],
        assert(allowedPaths.contains(initialRoute));

  @override
  Future<ParsedRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    final path = routeInformation.location!;
    // 参数没用
    final pathWithoutParams = Uri.parse(path).path;
    var parsedRoute = initialRoute;

    for (var pathTemplate in _pathTemplates) {
      if (pathTemplate == pathWithoutParams) {
        parsedRoute = ParsedRoute(path);
        return parsedRoute;
      }
    }

    return parsedRoute;
  }

  @override
  RouteInformation restoreRouteInformation(ParsedRoute configuration) =>
      RouteInformation(location: configuration.path);
}
