import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

extension LogicalKeyboardKeyParsing on LogicalKeyboardKey {
  KeyType get type {
    if (isDigit) return KeyType.digit;
    if (isAlphabet) return KeyType.alphabet;
    if (isSymbol) return KeyType.symbol;
    if (isSpace) return KeyType.space;
    if (isNormalChar) return KeyType.normal;
    if (isBackspace) return KeyType.backspace;
    if (isEnter) return KeyType.enter;
    if (isArrow) return KeyType.arrow;
    return KeyType.other;
  }

  bool get isDigit =>
      this >= LogicalKeyboardKey.digit0 && this <= LogicalKeyboardKey.digit9;

  bool get isAlphabet =>
      this >= LogicalKeyboardKey.keyA && this <= LogicalKeyboardKey.keyZ;

  bool get isSymbol =>
      this >= LogicalKeyboardKey.exclamation &&
      this <= LogicalKeyboardKey.tilde &&
      !isDigit &&
      !isAlphabet;

  bool get isSpace => this == LogicalKeyboardKey.space;

  bool get isNormalChar =>
      this >= LogicalKeyboardKey.space && this <= LogicalKeyboardKey.tilde;

  bool get isBackspace => this == LogicalKeyboardKey.backspace;

  bool get isEnter => this == LogicalKeyboardKey.enter;

  bool get isShift => this == LogicalKeyboardKey.shift;

  bool get isArrow =>
      this >= LogicalKeyboardKey.arrowDown &&
      this <= LogicalKeyboardKey.arrowUp;

  bool operator <=(LogicalKeyboardKey other) =>
      keyId.compareTo(other.keyId) <= 0;

  bool operator >=(LogicalKeyboardKey other) =>
      keyId.compareTo(other.keyId) >= 0;

  bool operator <(LogicalKeyboardKey other) => keyId.compareTo(other.keyId) < 0;

  bool operator >(LogicalKeyboardKey other) => keyId.compareTo(other.keyId) > 0;
}

enum KeyType {
  alphabet,
  digit,
  symbol,
  normal,
  space,
  backspace,
  enter,
  shift,
  arrow,
  other,
}

extension SingleActivatorParsing on SingleActivator {
  int get modifiers {
    var result = 0;
    if (control) result |= Modifiers.control;
    if (shift) result |= Modifiers.shift;
    if (alt) result |= Modifiers.alt;

    return result;
  }
}

class Modifiers {
  static const int control = 1 << 0;
  static const int shift = 1 << 1;
  static const int alt = 1 << 2;
}
