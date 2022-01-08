import 'package:flime/keyboard/basic/event.dart';
import 'package:flutter/services.dart';

import 'key.dart';

class Preset extends Iterable<KeyboardRow> {
  final double width;
  final double height;
  final rows = <KeyboardRow>[];

  Preset({
    required this.width,
    required this.height,
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
    var row = KeyboardRow(
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
  }) {
    var key = K(
      height: height ?? this.height,
      width: width ?? preset.width,
      preset: preset,
      click: click,
      label: label,
    );
    keys.add(key);
  }

  void c(
    LogicalKeyboardKey click, {
    String? label,
    double? width,
    double? height,
  }) {
    var key = K(
      height: height ?? this.height,
      width: width ?? preset.width,
      preset: preset,
      click: KEvent.click(click),
      label: label,
    );
    keys.add(key);
  }
}
