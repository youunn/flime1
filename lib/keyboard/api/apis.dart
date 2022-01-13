import 'package:flime/api/api.dart';

class Apis {
  static final ContextApi _contextApi = ContextApi();

  static ContextApi get contextApi => _contextApi;

  static final LayoutApi _layoutApi = LayoutApi();

  static LayoutApi get layoutApi => _layoutApi;
}
