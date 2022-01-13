import 'package:flime/api/api.dart';

class Apis {
  static ContextApi? _contextApi;

  static ContextApi get contextApi => _contextApi ??= ContextApi();

  static LayoutApi? _layoutApi;

  static LayoutApi get layoutApi => _layoutApi ??= LayoutApi();
}
