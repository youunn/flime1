// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../layouts/main_layout.dart' as _i1;
import '../layouts/primary_layout.dart' as _i2;
import '../layouts/secondary_layout.dart' as _i3;

class KeyboardRouter extends _i4.RootStackRouter {
  KeyboardRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MainLayout());
    },
    PrimaryRoute.name: (routeData) {
      final args = routeData.argsAs<PrimaryRouteArgs>(
          orElse: () => const PrimaryRouteArgs());
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.PrimaryLayout(key: args.key));
    },
    SecondaryRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.SecondaryLayout());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig('/#redirect',
            path: '/', redirectTo: '/keyboard', fullMatch: true),
        _i4.RouteConfig(MainRoute.name, path: '/keyboard', children: [
          _i4.RouteConfig('#redirect',
              path: '',
              parent: MainRoute.name,
              redirectTo: 'primary',
              fullMatch: true),
          _i4.RouteConfig(PrimaryRoute.name,
              path: 'primary', parent: MainRoute.name),
          _i4.RouteConfig(SecondaryRoute.name,
              path: 'secondary', parent: MainRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.MainLayout]
class MainRoute extends _i4.PageRouteInfo<void> {
  const MainRoute({List<_i4.PageRouteInfo>? children})
      : super(MainRoute.name, path: '/keyboard', initialChildren: children);

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.PrimaryLayout]
class PrimaryRoute extends _i4.PageRouteInfo<PrimaryRouteArgs> {
  PrimaryRoute({_i5.Key? key})
      : super(PrimaryRoute.name,
            path: 'primary', args: PrimaryRouteArgs(key: key));

  static const String name = 'PrimaryRoute';
}

class PrimaryRouteArgs {
  const PrimaryRouteArgs({this.key});

  final _i5.Key? key;

  @override
  String toString() {
    return 'PrimaryRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.SecondaryLayout]
class SecondaryRoute extends _i4.PageRouteInfo<void> {
  const SecondaryRoute() : super(SecondaryRoute.name, path: 'secondary');

  static const String name = 'SecondaryRoute';
}
