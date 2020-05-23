enum Level { 
  first,
  second,
  third,
  fourth,
  fifth
}

extension LevelExtention on Level {

  static final luxs = {
    Level.first: 40,
    Level.second: 80,
    Level.third: 120,
    Level.fourth: 160,
    Level.fifth: double.infinity,
  };

  static final values = {
    Level.first: 1,
    Level.second: 2,
    Level.third: 3,
    Level.fourth: 4,
    Level.fifth: 5,
  };

  int get lux => luxs[this];
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
    Value.one: Level.first.lux,
    Value.two: Level.second.lux,
    Value.three: Level.third.lux,
    Value.four: Level.fourth.lux,
    Value.five: Level.fifth.lux,
    Value.blank: null,
  };

  int get move => moves[this];
  int get range => ranges[this];

}

enum Card {
  one,
  two,
  three,
  four,
}

class Unlocker {


  List<Value> _values = [Value.blank, Value.blank, Value.blank, Value.blank];

  List<Value> get values => _values;

  bool isPinSet() {
    return !values.contains(Value.blank);
  }

  setCard(Card card, luxes) {
    switch(card) {
      case Card.one:
        _values[0] = getValue(luxes);
        break;
      case Card.two:
        
        break;
      case Card.three:
        
        break;
      case Card.four:
        
        break;
    }

  }

  Value getValue(int lux) {
    if (lux != null) {
      for(Value value in Value.values ) {
        if( lux < value.range ) return value;
      }
    }
    return Value.blank;
  }

}
