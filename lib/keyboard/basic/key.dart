import 'package:flime/input/core/event/event.dart';
import 'package:flime/keyboard/basic/highlights.dart';
import 'package:flime/keyboard/basic/preset.dart';
import 'package:flutter/material.dart';

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
  final IconData? iconData;
  final Highlight? highlight;
  final bool repeatable;
  final bool firstRow;

  K({
    required this.height,
    required this.width,
    required this.preset,
    required this.click,
    String? label,
    this.iconData,
    this.highlight,
    this.longClick,
    this.swipe,
    this.ascii,
    this.composing,
    this.repeatable = false,
    this.firstRow = false,
  })  : assert(width >= 0 && width <= 1),
        assert(height >= 0),
        assert(longClick == null || repeatable == false) {
    this.label = label ?? click.parseLabel();
  }
}
