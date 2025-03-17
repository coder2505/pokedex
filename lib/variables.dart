import 'package:flutter_riverpod/flutter_riverpod.dart';

int whatSelected = 0;

// ignore: camel_case_types
class varGlobal {
  static String currentOption = "";
}

class Variables extends StateNotifier<int> {
  Variables() : super(0);

  //0 for ascending
  // 1 for desending

  void setAnother(int set) {
    state = set;
  }
}

final buttonSelectionProvider = StateNotifierProvider<Variables, int>(
  (ref) => Variables(),
);
