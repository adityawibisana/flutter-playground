// ignore_for_file: avoid_print
import 'package:flutter_test/flutter_test.dart';

Stream<int> integerStream() async* {
  for (int i = 1; i <= double.maxFinite; i++) {
    await Future.delayed(const Duration(milliseconds: 100));
    yield i;
  }
}

void main() async {
  test('Check retrieving stream', () async {
    var stream = integerStream();
    stream.listen((event) {
      print("Receiving data ${event.toString()}");
    });

    await Future.delayed(const Duration(seconds: 1));
  });
}
