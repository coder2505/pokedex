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
