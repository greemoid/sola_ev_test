import 'package:flutter/cupertino.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_json.dart';

class MockAssetBundle extends Mock implements AssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    return mockJson; // Тут гарантуємо, що повертається рядок
  }
}
