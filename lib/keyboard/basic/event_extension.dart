import 'package:flutter/services.dart';

extension KeyEventParsing on LogicalKeyboardKey {
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

  bool operator <=(LogicalKeyboardKey other) =>
      keyId.compareTo(other.keyId) <= 0;

  bool operator >=(LogicalKeyboardKey other) =>
      keyId.compareTo(other.keyId) >= 0;

  bool operator <(LogicalKeyboardKey other) => keyId.compareTo(other.keyId) < 0;

  bool operator >(LogicalKeyboardKey other) => keyId.compareTo(other.keyId) > 0;
}

enum KeyType { alphabet, digit, space, backspace, enter, other }
