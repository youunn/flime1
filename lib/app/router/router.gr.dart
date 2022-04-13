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

import '../pages/home_page.dart' as _i1;
import '../pages/input_page.dart' as _i3;
import '../pages/setup_page.dart' as _i2;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    SetupRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SetupPage());
    },
    InputRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.InputPage());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(HomeRoute.name, path: '/'),
        _i4.RouteConfig(SetupRoute.name, path: '/setup'),
        _i4.RouteConfig(InputRoute.name, path: '/input')
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.SetupPage]
class SetupRoute extends _i4.PageRouteInfo<void> {
  const SetupRoute() : super(SetupRoute.name, path: '/setup');

  static const String name = 'SetupRoute';
}

/// generated route for
/// [_i3.InputPage]
class InputRoute extends _i4.PageRouteInfo<void> {
  const InputRoute() : super(InputRoute.name, path: '/input');

  static const String name = 'InputRoute';
}
