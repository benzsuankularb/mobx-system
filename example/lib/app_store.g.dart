// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStoreBase, Store {
  final _$counterAtom = Atom(name: '_AppStoreBase.counter');

  @override
  int get counter {
    _$counterAtom.reportRead();
    return super.counter;
  }

  @override
  set counter(int value) {
    _$counterAtom.reportWrite(value, super.counter, () {
      super.counter = value;
    });
  }

  final _$multiplyCounterAtom = Atom(name: '_AppStoreBase.multiplyCounter');

  @override
  int get multiplyCounter {
    _$multiplyCounterAtom.reportRead();
    return super.multiplyCounter;
  }

  @override
  set multiplyCounter(int value) {
    _$multiplyCounterAtom.reportWrite(value, super.multiplyCounter, () {
      super.multiplyCounter = value;
    });
  }

  @override
  String toString() {
    return '''
counter: ${counter},
multiplyCounter: ${multiplyCounter}
    ''';
  }
}
