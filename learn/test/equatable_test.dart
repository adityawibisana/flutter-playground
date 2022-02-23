import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

class PersonEquatableTest extends Equatable {
  final int age;
  final String name;

  const PersonEquatableTest({
    required this.age,
    required this.name,
  });

  @override
  List<Object?> get props => [age, name];
}

void main() async {
  group('Equatable lib tests', () {
    test('Equatable test', () async {
      const equatable1 = PersonEquatableTest(age: 0, name: "andy");
      const equatable2 = PersonEquatableTest(age: 0, name: "andy");
      expect(equatable1, equatable2);

      // different age
      const equatable3 = PersonEquatableTest(age: 1, name: "andy");
      const equatable4 = PersonEquatableTest(age: 2, name: "andy");
      expect(equatable3 == equatable4, false);

      // different name
      const equatable5 = PersonEquatableTest(age: 0, name: "andy");
      const equatable6 = PersonEquatableTest(age: 0, name: "bob");
      expect(equatable5 == equatable6, false);

      // different age and name
      const equatable7 = PersonEquatableTest(age: 0, name: "andy");
      const equatable8 = PersonEquatableTest(age: 1, name: "bob");
      expect(equatable7 == equatable8, false);
    });
  });
}
