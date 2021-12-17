import '../api/api.dart';

class KeyboardState {
  int height = 0;
}

class KeyboardStateApi extends LayoutApi {
  KeyboardState keyboardState;

  KeyboardStateApi(this.keyboardState);

  @override
  int getHeight() {
    return keyboardState.height;
  }
}
