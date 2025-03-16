import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';

class Pokemon {
  final String name;
  final String types1;
  final String types2;
  final String imageUrl;
  PaletteColor? color;

  Pokemon({
    required this.name,
    required this.types1,
    required this.types2,
    required this.imageUrl,
    this.color,
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

}

final pokemonListProvider = NotifierProvider<ProviderList, List<Pokemon>>(() {
  return ProviderList();
});
