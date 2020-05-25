enum Level { 
  first,
  second,
  third,
  fourth,
  fifth,
}

extension LevelExtention on Level {

  static final ranges = {
    Level.first: 40,
    Level.second: 80,
    Level.third: 120,
    Level.fourth: 160,
    Level.fifth: 10000,
  };

  static final values = {
    Level.first: 1,
    Level.second: 2,
    Level.third: 3,
    Level.fourth: 4,
    Level.fifth: 5,
  };

  int get range => ranges[this];
  int get value => values[this];

}

enum Value {
  one,
  two,
  three,
  four,
  five,
  blank,
}

extension ValueExtension on Value {
  static final moves = {
    Value.one: Level.first.value,
    Value.two: Level.second.value,
    Value.three: Level.third.value,
    Value.four: Level.fourth.value,
    Value.five: Level.fifth.value,
    Value.blank: null,
  };

  static final ranges = {
    Value.one: Level.first.range,
    Value.two: Level.second.range,
    Value.three: Level.third.range,
    Value.four: Level.fourth.range,
    Value.five: Level.fifth.range,
    Value.blank: null,
  };

  int get move => moves[this];
  int get range => ranges[this];

}

enum Cards {
  one,
  two,
  three,
  four,
}

enum Verifier {
  correct,
  incorrect,
}

abstract class CodeStatus {}

class UnlockingStatus extends CodeStatus {}

class SetCodeStatus extends CodeStatus {
  final Verifier verifier;
  SetCodeStatus(this.verifier);	
}

class Unlocker {

  final int pin;
  Unlocker(this.pin);

  List<Value> _values = [Value.blank, Value.blank, Value.blank, Value.blank];
  List<Value> get values => _values;
  Verifier _verifier;
  Verifier get verifier => _verifier;

  CodeStatus get state {
    if (!values.contains(Value.blank)){
      _verifier = isPinCorrect() ? Verifier.correct : Verifier.incorrect;
      return isPinCorrect() ? SetCodeStatus(Verifier.correct) : SetCodeStatus(Verifier.incorrect);
    } else {
      return UnlockingStatus();
    }
  }

  setCard(Cards card, luxes) {
    switch(card) {
      case Cards.one:
        _values[0] = getValue(luxes);
        break;
      case Cards.two:
        _values[1] = getValue(luxes);
        break;
      case Cards.three:
        _values[2] = getValue(luxes);
        break;
      case Cards.four:
        _values[3] = getValue(luxes);
        break;
    }
  }

  Value getValue(int lux) {
    if (lux != null) {
      for(Value value in Value.values ) {
        if( lux <= value.range ) return value;
      }
    }
    return Value.blank;
  }

  bool isPinCorrect() => pin == (values[0].move * 1000 + values[1].move * 100 + values[2].move * 10 + values[3].move * 1);

  void reset() {
    _values = [Value.blank, Value.blank, Value.blank, Value.blank];
  }

}
