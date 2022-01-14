import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

extension LogicalKeyboardKeyParsing on LogicalKeyboardKey {
  KeyType get type {
    if (isDigit) {
      return KeyType.digit;
    }
    if (isAlphabet) {
      return KeyType.alphabet;
    }
    if (isSpace) return KeyType.space;
    if (isBackspace) return KeyType.backspace;
    if (isEnter) return KeyType.enter;
    return KeyType.other;
  }

  bool get isDigit =>
      this >= LogicalKeyboardKey.digit0 && this <= LogicalKeyboardKey.digit9;

  bool get isAlphabet =>
      this >= LogicalKeyboardKey.keyA && this <= LogicalKeyboardKey.keyZ;

  bool get isSpace => this == LogicalKeyboardKey.space;

  bool get isBackspace => this == LogicalKeyboardKey.backspace;

  bool get isEnter => this == LogicalKeyboardKey.enter;

  bool get isShift => this == LogicalKeyboardKey.shift;

  bool operator <=(LogicalKeyboardKey other) =>
      keyId.compareTo(other.keyId) <= 0;

  bool operator >=(LogicalKeyboardKey other) =>
      keyId.compareTo(other.keyId) >= 0;

  bool operator <(LogicalKeyboardKey other) => keyId.compareTo(other.keyId) < 0;

  bool operator >(LogicalKeyboardKey other) => keyId.compareTo(other.keyId) > 0;
}

enum KeyType { alphabet, digit, space, backspace, enter, shift, other }

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
