import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

enum Operation {
  switchLayout,
}

class Operations {
  static Future switchLayout(BuildContext context, PageRouteInfo route) async {
    await context.router.replace(route);
  }
}