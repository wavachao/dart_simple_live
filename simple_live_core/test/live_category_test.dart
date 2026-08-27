import 'dart:convert';

import 'package:simple_live_core/simple_live_core.dart';
import 'package:test/test.dart';

void main() {
  test('serializes nested live categories recursively', () {
    final category = LiveCategory(
      id: 'root',
      name: 'Root',
      children: [
        LiveSubCategory(
          id: 'child',
          name: 'Child',
          parentId: 'root',
          children: [
            LiveSubCategory(
              id: 'grandchild',
              name: 'Grandchild',
              parentId: 'child',
            ),
          ],
        ),
      ],
    );

    final encoded = json.decode(category.toString()) as Map<String, dynamic>;
    final children = encoded['children'] as List<dynamic>;
    final child = children.single as Map<String, dynamic>;
    final grandchildren = child['children'] as List<dynamic>;

    expect(child['id'], 'child');
    expect((grandchildren.single as Map<String, dynamic>)['id'], 'grandchild');
  });
}
