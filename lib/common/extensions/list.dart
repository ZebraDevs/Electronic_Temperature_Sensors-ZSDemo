import 'package:flutter/material.dart';

extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  bool containsAll(Iterable<E> collection) {
    return collection.every((element) => contains(element));
  }

  Iterable<T> indexedMap<T>(T Function(E e, int index) toElement) {
    int idx = -1;
    return map((e) {
      idx++;
      return toElement(e, idx);
    });
  }
}

extension ListDivider on List<Widget> {
  Iterable<Widget> divide(Widget separator) sync* {
    if (isEmpty) return;

    final Iterator<Widget> iterator = this.iterator;
    iterator.moveNext();
    yield iterator.current;
    while (iterator.moveNext()) {
      yield separator;
      yield iterator.current;
    }
  }
}
