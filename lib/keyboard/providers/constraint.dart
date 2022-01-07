import 'package:flime/api/api.dart';
import 'package:flutter/cupertino.dart';

class Constraint extends ChangeNotifier {
  double _baseHeight = 0;

  double _height = 192;

  double _dpr = 1;

  double get height => _height;

  final layoutApi = LayoutApi();

  set height(double value) {
    if (_height != value) {
      _height = value;
      notify();
    }
  }

  double get baseHeight => _baseHeight;

  set baseHeight(double value) {
    if (_baseHeight != value) {
      _baseHeight = value;
      notify();
    }
  }

  double get dpr => _dpr;

  set dpr(double value) {
    if (_dpr != value) {
      _dpr = value;
      notify();
    }
  }

  void notify() {
    notifyListeners();
    layoutApi.setHeight(((_baseHeight + _height) * _dpr).toInt());
  }
}
