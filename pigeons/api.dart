import 'package:pigeon/pigeon.dart';

class Content {
  String? text;
}

@HostApi()
abstract class ContextApi {
  bool commit(Content content);
  bool send(String keyLabel);
  bool sendShortcut(String keyLabel, int modifier);
}

@HostApi()
abstract class InputMethodApi {
  bool enable();
  bool pick();
}


@HostApi()
abstract class LayoutApi {
  void setHeight(int height);
}
