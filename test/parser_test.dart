import 'package:flutter_test/flutter_test.dart';
import '../lib/logic/parser.dart';

void main() {
  test('test good input' , () {
    var result = parser('40');
    expect(result, 180);
  });

  test('test null input' , () {
    var result = parser('');
    expect(result, null);
  });

  test('test text value' , () {
    var result = parser('abc');
    expect(result, null);
  });

  test('test mixed number & text value' , () {
    var result = parser('18o');
    expect(result, null);
  });
}