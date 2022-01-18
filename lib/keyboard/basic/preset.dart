import 'package:flime/input/core/event/event.dart';
import 'package:flime/keyboard/basic/highlights.dart';
import 'package:flime/keyboard/basic/key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Preset extends Iterable<KeyboardRow> {
  final double width;
  final double height;
  final double fontSize;
  final rows = <KeyboardRow>[];

  Preset({
    required this.width,
    required this.height,
    required this.fontSize,
  })  : assert(width >= 0 && width <= 1),
        assert(height >= 0);

  @override
  Iterator<KeyboardRow> get iterator => rows.iterator;

  double get totalHeight =>
      rows.fold(0, (value, element) => value + element.height);

  void r(
    KeyboardRow Function(KeyboardRow) init, {
    double? height,
  }) {
    final row = KeyboardRow(
      height: height ?? this.height,
      preset: this,
    );
    rows.add(init(row));
  }
}

class KeyboardRow extends Iterable<K> {
  final double height;
  final Preset preset;
  final keys = <K>[];

  KeyboardRow({required this.height, required this.preset})
      : assert(height >= 0);

  @override
  Iterator<K> get iterator => keys.iterator;

  void k(
    KEvent click, {
    String? label,
    double? width,
    double? height,
    KEvent? longClick,
    KEvent? swipe,
    KEvent? ascii,
    KEvent? composing,
    IconData? iconData,
    Highlight? highlight,
    bool repeatable = false,
  }) {
    final key = K(
      height: height ?? this.height,
      width: width ?? preset.width,
      preset: preset,
      click: click,
      label: label,
      longClick: longClick,
      swipe: swipe,
      ascii: ascii,
      composing: composing,
      iconData: iconData,
      highlight: highlight,
      repeatable: repeatable,
    );
    keys.add(key);
  }

  void c(
    LogicalKeyboardKey click, {
    String? label,
    double? width,
    double? height,
    KEvent? longClick,
    KEvent? swipe,
    KEvent? ascii,
    KEvent? composing,
    IconData? iconData,
    Highlight? highlight,
    bool repeatable = false,
  }) {
    final key = K(
      height: height ?? this.height,
      width: width ?? preset.width,
      preset: preset,
      click: KEvent.click(click),
      label: label,
      longClick: longClick,
      swipe: swipe,
      ascii: ascii,
      composing: composing,
      iconData: iconData,
      highlight: highlight,
      repeatable: repeatable,
    );
    keys.add(key);
  }
}
