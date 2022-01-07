class Preset extends Iterable<KeyboardRow> {
  List<KeyboardRow> rows = [];
  double width;
  double height;

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
      width: width,
    );
    rows.add(init(row));
  }
}

class KeyboardRow extends Iterable<KeyboardKey> {
  double height;
  double width;
  List<KeyboardKey> keys = [];

  KeyboardRow({required this.height, required this.width})
      : assert(height >= 0),
        assert(width >= 0 && width <= 1);

  @override
  Iterator<KeyboardKey> get iterator => keys.iterator;

  void k(
    String label, {
    String click = '',
    double? width,
    double? height,
    Special special = Special.text,
  }) {
    if (click == '') click = label;
    var key = KeyboardKey(
        label: label,
        click: click,
        height: height ?? this.height,
        width: width ?? this.width,
        special: special);
    keys.add(key);
  }
}

class KeyboardKey {
  /// 高，单位dpr。
  double height;

  /// 宽，单位是屏占比。
  double width;

  /// 点击事件。
  String click;

  String label;

  Special special;

  KeyboardKey({
    required this.label,
    required this.click,
    required this.height,
    required this.width,
    this.special = Special.text,
  })  : assert(width >= 0 && width <= 1),
        assert(height >= 0);
}

enum Special { text, backspace, enter }
