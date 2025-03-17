import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';

class Pokemon {
  final String name;
  final String types1;
  final String types2;
  final String imageUrl;
  PaletteColor? color;
  final int hp;
  final int attack;
  final int defense;
  final int speed;
  final int spAttack;
  final int spDefense;

  Pokemon({
    required this.name,
    required this.types1,
    required this.types2,
    required this.imageUrl,
    this.color,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speed,
    required this.spAttack,
    required this.spDefense,
  });
}

class ProviderList extends Notifier<List<Pokemon>> {
  @override
  List<Pokemon> build() {
    return [];
  }

  void add(Pokemon obj) {
    state = [...state, obj];
  }

  void addColor(PaletteColor? c, indx) {
    state[indx].color = c;
  }

  int length() {
    return state.length;
  }

  void sortAlphabeticalAscending() {
    final newList = [...state];

    newList.sort((a, b) => a.name.compareTo(b.name));

    state = newList;
  }

  void sortAlphabeticalDescending() {
    final newList = [...state];

    newList.sort((a, b) => b.name.compareTo(a.name));

    state = newList;
  }

  void sortHPAscending() {
    final newList = [...state];

    newList.sort((a, b) => a.hp.compareTo(b.hp));

    state = newList;
  }

  void sortHPDescending() {
    final newList = [...state];

    newList.sort((a, b) => b.hp.compareTo(a.hp));

    state = newList;
  }

  void sortAttackAscending() {
    final newList = [...state];
    newList.sort((a, b) => a.attack.compareTo(b.attack));

    state = newList;
  }

  void sortAttackDescending() {
    final newList = [...state];
    newList.sort((a, b) => b.attack.compareTo(a.attack));

    state = newList;
  }

  void sortDefenseAscending() {
    final newList = [...state];
    newList.sort((a, b) => a.defense.compareTo(b.defense));

    state = newList;
  }

  void sortDefenseDescending() {
    final newList = [...state];
    newList.sort((a, b) => b.defense.compareTo(a.defense));

    state = newList;
  }

  void sortSpeedAscending() {
    final newList = [...state];
    newList.sort((a, b) => a.speed.compareTo(b.speed));
    state = newList;
  }

  void sortSpeedDescending() {
    final newList = [...state];
    newList.sort((a, b) => b.speed.compareTo(a.speed));
    state = newList;
  }

  void sortSpecialAttackAscending() {
    final newList = [...state];
    newList.sort((a, b) => a.spAttack.compareTo(b.spAttack));
    state = newList;
  }

  void sortSpecialAttackDescending() {
    final newList = [...state];
    newList.sort((a, b) => b.spAttack.compareTo(a.spAttack));
    state = newList;
  }

  void sortSpecialDefenseAscending() {
    final newList = [...state];
    newList.sort((a, b) => a.spDefense.compareTo(b.spDefense));
    state = newList;
  }

  void sortSpecialDefenseDescending() {
    final newList = [...state];
    newList.sort((a, b) => b.spDefense.compareTo(a.spDefense));
    state = newList;
  }
}

final pokemonListProvider = NotifierProvider<ProviderList, List<Pokemon>>(() {
  return ProviderList();
});
