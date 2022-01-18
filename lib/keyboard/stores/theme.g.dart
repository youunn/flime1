// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$KeyboardTheme on _KeyboardTheme, Store {
  final _$darkModeAtom = Atom(name: '_KeyboardTheme.darkMode');

  @override
  bool get darkMode {
    _$darkModeAtom.reportRead();
    return super.darkMode;
  }

  @override
  set darkMode(bool value) {
    _$darkModeAtom.reportWrite(value, super.darkMode, () {
      super.darkMode = value;
    });
  }

  @override
  String toString() {
    return '''
darkMode: ${darkMode}
    ''';
  }
}
