// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../layouts/candidates_layout.dart' as _i4;
import '../layouts/main_layout.dart' as _i1;
import '../layouts/primary_layout.dart' as _i2;
import '../layouts/secondary_layout.dart' as _i3;

class KeyboardRouter extends _i5.RootStackRouter {
  KeyboardRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MainLayout());
    },
    PrimaryRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.PrimaryLayout());
    },
    SecondaryRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.SecondaryLayout());
    },
    CandidatesRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.CandidatesLayout());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig('/#redirect',
            path: '/', redirectTo: '/keyboard', fullMatch: true),
        _i5.RouteConfig(MainRoute.name, path: '/keyboard', children: [
          _i5.RouteConfig('#redirect',
              path: '',
              parent: MainRoute.name,
              redirectTo: 'primary',
              fullMatch: true),
          _i5.RouteConfig(PrimaryRoute.name,
              path: 'primary', parent: MainRoute.name),
          _i5.RouteConfig(SecondaryRoute.name,
              path: 'secondary', parent: MainRoute.name),
          _i5.RouteConfig(CandidatesRoute.name,
              path: 'candidates', parent: MainRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.MainLayout]
class MainRoute extends _i5.PageRouteInfo<void> {
  const MainRoute({List<_i5.PageRouteInfo>? children})
      : super(MainRoute.name, path: '/keyboard', initialChildren: children);

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.PrimaryLayout]
class PrimaryRoute extends _i5.PageRouteInfo<void> {
  const PrimaryRoute() : super(PrimaryRoute.name, path: 'primary');

  static const String name = 'PrimaryRoute';
}

/// generated route for
/// [_i3.SecondaryLayout]
class SecondaryRoute extends _i5.PageRouteInfo<void> {
  const SecondaryRoute() : super(SecondaryRoute.name, path: 'secondary');

  static const String name = 'SecondaryRoute';
}

/// generated route for
/// [_i4.CandidatesLayout]
class CandidatesRoute extends _i5.PageRouteInfo<void> {
  const CandidatesRoute() : super(CandidatesRoute.name, path: 'candidates');

  static const String name = 'CandidatesRoute';
}
