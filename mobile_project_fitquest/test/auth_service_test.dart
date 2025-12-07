import 'package:flutter_test/flutter_test.dart';

// Simple test without mocks
void main() {
  test('Basic math test', () {
    expect(1 + 1, equals(2));
    expect(2 * 2, equals(4));
    expect(10 - 5, equals(5));
  });

  test('String tests', () {
    expect('Hello', isNotNull);
    expect('Hello'.length, equals(5));
    expect('Hello', contains('ell'));
  });

  test('List tests', () {
    final list = [1, 2, 3, 4, 5];
    expect(list.length, equals(5));
    expect(list, contains(3));
    expect(list.first, equals(1));
    expect(list.last, equals(5));
  });

  test('Map tests', () {
    final map = {'name': 'John', 'age': 25};
    expect(map.length, equals(2));
    expect(map['name'], equals('John'));
    expect(map.containsKey('age'), isTrue);
  });

  test('Boolean tests', () {
    expect(true, isTrue);
    expect(false, isFalse);
    expect(!false, isTrue);
  });
}