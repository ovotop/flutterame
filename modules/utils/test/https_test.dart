@Timeout(const Duration(seconds: 45))

import 'package:flutter_test/flutter_test.dart';

import 'package:utils/https.dart';

void main() {
  test('Https.get', () async {
    var users = await Https.get(
        "https://jsonplaceholder.typicode.com/users", {"id": 3});

    print(users.runtimeType);
    print(users);
    // var datasMap = new Map<String, dynamic>.from(users);
    // const
    // expect(datas.length, 1);
    expect(users['username'], 'Samantha');
  });
}
