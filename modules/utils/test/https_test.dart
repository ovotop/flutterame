import 'package:flutter_test/flutter_test.dart';

import 'package:utils/https.dart';

void main() {
  test('Https.get', () async {
    await Https.get("https://jsonplaceholder.typicode.com/users", {"id": 3});
    print("done");
  });
}
