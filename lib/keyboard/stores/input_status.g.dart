// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_status.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InputStatus on _InputStatus, Store {
  final _$candidatesAtom = Atom(name: '_InputStatus.candidates');

  @override
  ObservableList<String> get candidates {
    _$candidatesAtom.reportRead();
    return super.candidates;
  }

  @override
  set candidates(ObservableList<String> value) {
    _$candidatesAtom.reportWrite(value, super.candidates, () {
      super.candidates = value;
    });
  }

  final _$inputAtom = Atom(name: '_InputStatus.input');

  @override
  String get input {
    _$inputAtom.reportRead();
    return super.input;
  }

  @override
  set input(String value) {
    _$inputAtom.reportWrite(value, super.input, () {
      super.input = value;
    });
  }

  final _$shiftedAtom = Atom(name: '_InputStatus.shifted');

  @override
  bool get shifted {
    _$shiftedAtom.reportRead();
    return super.shifted;
  }

  @override
  set shifted(bool value) {
    _$shiftedAtom.reportWrite(value, super.shifted, () {
      super.shifted = value;
    });
  }

  final _$_InputStatusActionController = ActionController(name: '_InputStatus');

  @override
  void update() {
    final _$actionInfo =
        _$_InputStatusActionController.startAction(name: '_InputStatus.update');
    try {
      return super.update();
    } finally {
      _$_InputStatusActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
candidates: ${candidates},
input: ${input},
shifted: ${shifted}
    ''';
  }
}
