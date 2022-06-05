import 'package:flutter_test/flutter_test.dart';

void main() {
  test('date', () {
    final currentDate = DateTime.now();
    final customDate = DateTime(2022, 6, 5, 21, 1, 1);
    print(currentDate.difference(customDate).inDays);

    expect(customDate.difference(currentDate).inDays == 0, true);
  });
}
