import 'package:flime/input/core/event/event.dart';
import 'package:flime/keyboard/basic/preset.dart';

class K {
  /// 高，单位dpr。
  final double height;

  /// 宽，单位是屏占比。
  final double width;

  final Preset preset;

  late final String label;

  final KEvent click;
  final KEvent? longClick;
  final KEvent? swipe;
  final KEvent? ascii;
  final KEvent? composing;

  K({
    required this.height,
    required this.width,
    required this.preset,
    required this.click,
    String? label,
    this.longClick,
    this.swipe,
    this.ascii,
    this.composing,
  })  : assert(width >= 0 && width <= 1),
        assert(height >= 0) {
    this.label = label ?? click.parseLabel();
  }
}
