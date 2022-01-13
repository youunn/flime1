import 'package:flime/api/api.dart';
import 'package:flime/keyboard/api/apis.dart';
import 'package:mobx/mobx.dart';

part 'constraint.g.dart';

class Constraint = _Constraint with _$Constraint;

abstract class _Constraint with Store {
  @observable
  double baseHeight = 38;
  @observable
  double height = 192;
  @observable
  double dpr = 1;

  final LayoutApi layoutApi = Apis.layoutApi;
  // ignore: unused_field
  late final ReactionDisposer _notifyNative;

  void setupReactions() {
    _notifyNative = reaction((_) => totalHeightInPx, (int h) {
      layoutApi.setHeight(h);
    });
  }

  @computed
  int get totalHeightInPx => ((baseHeight + height) * dpr).toInt();
}
