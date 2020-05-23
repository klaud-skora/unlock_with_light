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
