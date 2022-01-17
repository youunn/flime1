import 'package:flime/api/api.dart';
import 'package:flime/keyboard/api/apis.dart';
import 'package:mobx/mobx.dart';

part 'constraint.g.dart';

class Constraint = _Constraint with _$Constraint;

abstract class _Constraint with Store {
  @observable
  double baseHeight = 30;
  @readonly
  double _height = 192;
  @readonly
  double _dpr = 1;

  final LayoutApi layoutApi = scopedLayoutApi;

  @computed
  int get totalHeightInPx => ((baseHeight + _height) * _dpr).toInt();

  // ignore: unused_field
  late final ReactionDisposer _notifyNative;

  void setupReactions() {
    _notifyNative = reaction(
      (_) => totalHeightInPx,
      (int h) => layoutApi.setHeight(h),
      delay: 100,
    );
  }

  @action
  void setHeightAndDpr(double h, double d) {
    _dpr = d;
    _height = h;
  }
}
