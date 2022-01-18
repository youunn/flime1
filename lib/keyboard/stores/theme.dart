import 'package:mobx/mobx.dart';

part 'theme.g.dart';

class KeyboardTheme = _KeyboardTheme with _$KeyboardTheme;

abstract class _KeyboardTheme with Store {
  @observable
  bool darkMode = true;
}
