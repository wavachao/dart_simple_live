import 'dart:collection';

/// A bounded FIFO queue which keeps the newest values when producers outrun
/// consumers.
///
/// Live chat is best-effort data. Dropping old messages is preferable to an
/// ever-growing backlog which can monopolize the Flutter UI isolate.
class DropOldestQueue<T> {
  final int capacity;
  final Queue<T> _items = Queue<T>();

  DropOldestQueue(this.capacity) {
    if (capacity <= 0) {
      throw ArgumentError.value(capacity, 'capacity', 'must be positive');
    }
  }

  int get length => _items.length;
  bool get isEmpty => _items.isEmpty;
  bool get isNotEmpty => _items.isNotEmpty;

  /// Adds [value] and returns the number of old values discarded.
  int add(T value) {
    var dropped = 0;
    while (_items.length >= capacity) {
      _items.removeFirst();
      dropped += 1;
    }
    _items.addLast(value);
    return dropped;
  }

  List<T> takeFirst(int count) {
    if (count <= 0 || _items.isEmpty) {
      return <T>[];
    }
    final result = <T>[];
    final takeCount = count < _items.length ? count : _items.length;
    for (var i = 0; i < takeCount; i++) {
      result.add(_items.removeFirst());
    }
    return result;
  }

  void clear() => _items.clear();
}
