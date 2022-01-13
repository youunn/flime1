// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constraint.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Constraint on _Constraint, Store {
  Computed<int>? _$totalHeightInPxComputed;

  @override
  int get totalHeightInPx =>
      (_$totalHeightInPxComputed ??= Computed<int>(() => super.totalHeightInPx,
              name: '_Constraint.totalHeightInPx'))
          .value;

  final _$baseHeightAtom = Atom(name: '_Constraint.baseHeight');

  @override
  double get baseHeight {
    _$baseHeightAtom.reportRead();
    return super.baseHeight;
  }

  @override
  set baseHeight(double value) {
    _$baseHeightAtom.reportWrite(value, super.baseHeight, () {
      super.baseHeight = value;
    });
  }

  final _$heightAtom = Atom(name: '_Constraint.height');

  @override
  double get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(double value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  final _$dprAtom = Atom(name: '_Constraint.dpr');

  @override
  double get dpr {
    _$dprAtom.reportRead();
    return super.dpr;
  }

  @override
  set dpr(double value) {
    _$dprAtom.reportWrite(value, super.dpr, () {
      super.dpr = value;
    });
  }

  @override
  String toString() {
    return '''
baseHeight: ${baseHeight},
height: ${height},
dpr: ${dpr},
totalHeightInPx: ${totalHeightInPx}
    ''';
  }
}
