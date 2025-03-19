import 'package:flutter_riverpod/flutter_riverpod.dart';

int whatSelected = 0;
List offsetLimit = [0, 1025];

// ignore: camel_case_types
class varGlobal {
  static String currentOption = "";
  static String? currentOptionGen = "";

  static List<int> startIndexOfLeagues = [
    0,
    152,
    252,
    387,
    494,
    650,
    722,
    810,
    906,
  ];
  static List<int> endIndexOfLeagues = [
    151,
    251,
    386,
    493,
    649,
    721,
    809,
    905,
    1025,
  ];
}

class Variables extends StateNotifier<int> {
  Variables() : super(0);

  //0 for ascending
  // 1 for desending

  void setAnother(int set) {
    state = set;
  }
}

class Limit extends StateNotifier<List<int>> {
  Limit(super.state);

  void setnewLimit(int offset, int limit) {
    state[0] = offset;
    state[1] = limit;
  }

  int getOffset() {
    return state[0];
  }

  int getLimit() {
    return state[1];
  }
}

final buttonSelectionProvider = StateNotifierProvider<Variables, int>(
  (ref) => Variables(),
);

final limitProvider = StateNotifierProvider<Limit, List>(
  (ref) => Limit([0, 1025]),
);
