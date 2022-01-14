import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

enum Operation {
  switchLayout,
}

class Operations {
  static void switchLayout(BuildContext context, PageRouteInfo route) {
    context.router.replace(route);
  }
}
