import 'package:simple_live_core/src/common/drop_oldest_queue.dart';
import 'package:test/test.dart';

void main() {
  group('DropOldestQueue', () {
    test('keeps the newest values when capacity is exceeded', () {
      final queue = DropOldestQueue<int>(3);

      expect(queue.add(1), 0);
      expect(queue.add(2), 0);
      expect(queue.add(3), 0);
      expect(queue.add(4), 1);

      expect(queue.takeFirst(10), [2, 3, 4]);
      expect(queue, isEmpty);
    });

    test('takes values in bounded FIFO batches', () {
      final queue = DropOldestQueue<int>(5);
      for (var value = 0; value < 5; value++) {
        queue.add(value);
      }

      expect(queue.takeFirst(2), [0, 1]);
      expect(queue.length, 3);
      expect(queue.takeFirst(2), [2, 3]);
      expect(queue.takeFirst(2), [4]);
    });

    test('rejects a non-positive capacity', () {
      expect(() => DropOldestQueue<int>(0), throwsArgumentError);
    });
  });
}
