import 'package:auto_route/auto_route.dart';
import 'package:flime/app/pages/home_page.dart';
import 'package:flime/app/pages/input_page.dart';
import 'package:flime/app/pages/setup_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, path: '/'),
    AutoRoute(page: SetupPage, path: '/setup'),
    AutoRoute(page: InputPage, path: '/input'),
  ],
)
class $AppRouter {}
