import 'package:flutter_test/flutter_test.dart';
import '../lib/logic/unlocker.dart';

void main() {

  /* TEST APP STATUS */ 
  test('default state', () {
    Unlocker unlocker = Unlocker(1111);
    expect((unlocker.state is UnlockingStatus),  true);
  });

  test('state with one selected value', () {
    Unlocker unlocker = Unlocker(1111);
    unlocker.setCard(Cards.one, 150);
    expect(unlocker.state is UnlockingStatus,  true);
  });

  test('state with two selected values', () {
    Unlocker unlocker = Unlocker(1111);
    unlocker.setCard(Cards.one, 150);
    unlocker.setCard(Cards.two, 200);
    expect(unlocker.state is UnlockingStatus,  true);
  });

  test('state with three selected values', () {
    Unlocker unlocker = Unlocker(1111);
    unlocker.setCard(Cards.one, 150);
    unlocker.setCard(Cards.two, 200);
    unlocker.setCard(Cards.three, 33);
    expect(unlocker.state is UnlockingStatus,  true);
  });

  test('state with completed pin', () {
    Unlocker unlocker = Unlocker(1111);
    unlocker.setCard(Cards.one, 150);
    unlocker.setCard(Cards.two, 200);
    unlocker.setCard(Cards.three, 33);
    unlocker.setCard(Cards.four, 90);
    expect(unlocker.state is SetCodeStatus,  true);
  });
  
  /* TEST PIN */ 
  test('good pin', () {
    Unlocker unlocker = Unlocker(1111);
    unlocker.setCard(Cards.one, 33);
    unlocker.setCard(Cards.two, 33);
    unlocker.setCard(Cards.three, 33);
    unlocker.setCard(Cards.four, 33);
    var status = unlocker.state is SetCodeStatus;
    expect(status, true);
    expect(unlocker.verifier.value, true);
  });

  test('good pin 2', () {
    Unlocker unlocker = Unlocker(1111);
    unlocker.setCard(Cards.one, 0);
    unlocker.setCard(Cards.two, 40);
    unlocker.setCard(Cards.three, 40);
    unlocker.setCard(Cards.four, 40);
    var status = unlocker.state is SetCodeStatus;
    expect(status, true);
    expect(unlocker.verifier.value, true);
  });

  test('wrong pin', () {
    Unlocker unlocker = Unlocker(1111);
    unlocker.setCard(Cards.one, 41);
    unlocker.setCard(Cards.two, 41);
    unlocker.setCard(Cards.three, 41);
    unlocker.setCard(Cards.four, 41);
    var status = unlocker.state is SetCodeStatus;
    expect(status, true);
    expect(unlocker.verifier.value, false);
  });

  test('wrong pin 2', () {
    Unlocker unlocker = Unlocker(1111);
    unlocker.setCard(Cards.one, 55);
    unlocker.setCard(Cards.two, 66);
    unlocker.setCard(Cards.three, 88);
    unlocker.setCard(Cards.four, 200);
    var status = unlocker.state is SetCodeStatus;
    expect(status, true);
    expect(unlocker.verifier.value, false);
  });

  test('wrong pin 3', () {
    Unlocker unlocker = Unlocker(2222);
    unlocker.setCard(Cards.one, 40);
    unlocker.setCard(Cards.two, 80);
    unlocker.setCard(Cards.three, 80);
    unlocker.setCard(Cards.four, 80);
    var status = unlocker.state is SetCodeStatus;
    expect(status, true);
    expect(unlocker.verifier.value, false);
  });

  test('wrong pin 4', () {
    Unlocker unlocker = Unlocker(5555);
    unlocker.setCard(Cards.one, 150);
    unlocker.setCard(Cards.two, 200);
    unlocker.setCard(Cards.three, 33);
    unlocker.setCard(Cards.four, 190);
    var status = unlocker.state is SetCodeStatus;
    expect(status, true);
    expect(unlocker.verifier.value, false);
  });

}