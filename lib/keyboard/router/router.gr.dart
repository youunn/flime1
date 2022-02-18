// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../layouts/candidates_layout.dart' as _i5;
import '../layouts/main_layout.dart' as _i1;
import '../layouts/number_layout.dart' as _i4;
import '../layouts/primary_layout.dart' as _i2;
import '../layouts/secondary_layout.dart' as _i3;

class KeyboardRouter extends _i6.RootStackRouter {
  KeyboardRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.MainLayout());
    },
    PrimaryRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.PrimaryLayout());
    },
    SecondaryRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.SecondaryLayout());
    },
    NumberRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.NumberLayout());
    },
    CandidatesRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.CandidatesLayout());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig('/#redirect',
            path: '/', redirectTo: '/keyboard', fullMatch: true),
        _i6.RouteConfig(MainRoute.name, path: '/keyboard', children: [
          _i6.RouteConfig('#redirect',
              path: '',
              parent: MainRoute.name,
              redirectTo: 'primary',
              fullMatch: true),
          _i6.RouteConfig(PrimaryRoute.name,
              path: 'primary', parent: MainRoute.name),
          _i6.RouteConfig(SecondaryRoute.name,
              path: 'secondary', parent: MainRoute.name),
          _i6.RouteConfig(NumberRoute.name,
              path: 'number', parent: MainRoute.name),
          _i6.RouteConfig(CandidatesRoute.name,
              path: 'candidates', parent: MainRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.MainLayout]
class MainRoute extends _i6.PageRouteInfo<void> {
  const MainRoute({List<_i6.PageRouteInfo>? children})
      : super(MainRoute.name, path: '/keyboard', initialChildren: children);

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i2.PrimaryLayout]
class PrimaryRoute extends _i6.PageRouteInfo<void> {
  const PrimaryRoute() : super(PrimaryRoute.name, path: 'primary');

  static const String name = 'PrimaryRoute';
}

/// generated route for
/// [_i3.SecondaryLayout]
class SecondaryRoute extends _i6.PageRouteInfo<void> {
  const SecondaryRoute() : super(SecondaryRoute.name, path: 'secondary');

  static const String name = 'SecondaryRoute';
}

/// generated route for
/// [_i4.NumberLayout]
class NumberRoute extends _i6.PageRouteInfo<void> {
  const NumberRoute() : super(NumberRoute.name, path: 'number');

  static const String name = 'NumberRoute';
}

/// generated route for
/// [_i5.CandidatesLayout]
class CandidatesRoute extends _i6.PageRouteInfo<void> {
  const CandidatesRoute() : super(CandidatesRoute.name, path: 'candidates');

  static const String name = 'CandidatesRoute';
}
