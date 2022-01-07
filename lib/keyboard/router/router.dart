import 'package:auto_route/annotations.dart';
import 'package:flime/keyboard/layouts/main_layout.dart';
import 'package:flime/keyboard/layouts/primary_layout.dart';
import 'package:flime/keyboard/layouts/secondary_layout.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Layout,Route',
  routes: [
    RedirectRoute(path: '/', redirectTo: '/keyboard'),
    AutoRoute(
      path: '/keyboard',
      page: MainLayout,
      children: <AutoRoute>[
        RedirectRoute(path: '', redirectTo: 'primary'),
        AutoRoute(path: 'primary', page: PrimaryLayout),
        AutoRoute(path: 'secondary', page: SecondaryLayout),
      ],
    ),
  ],
)
class $KeyboardRouter {}
