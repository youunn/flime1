import 'package:pigeon/pigeon.dart';

class Content {
  String? text;
}

@HostApi()
abstract class ContextApi {
  bool commit(Content content);
  bool delete();
}

@HostApi()
abstract class InputMethodApi {
  bool enable();
  bool pick();
}


@FlutterApi()
abstract class LayoutApi {
  @async
  int getHeight();
}
