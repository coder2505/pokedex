import 'package:flutter/material.dart';

Color getPokemonTypeColorType1(String type) {
  switch (type) {
    case 'Fire':
      return Colors.orangeAccent;
    case 'Water':
      return Colors.blueAccent;
    case 'Grass':
      return Colors.greenAccent.shade700;
    case 'Electric':
      return Colors.yellow.shade700;
    case 'Ice':
      return Colors.cyanAccent;
    case 'Fighting':
      return Colors.brown.shade700;
    case 'Poison':
      return Colors.purple;
    case 'Ground':
      return Colors.brown.shade400;
    case 'Flying':
      return Colors.blue.shade300;
    case 'Psychic':
      return Colors.pinkAccent;
    case 'Bug':
      return Colors.lightGreen.shade700;
    case 'Rock':
      return Colors.grey.shade600;
    case 'Ghost':
      return Colors.deepPurpleAccent;
    case 'Dragon':
      return Colors.indigoAccent;
    case 'Dark':
      return Colors.black87;
    case 'Steel':
      return Colors.blueGrey;
    case 'Fairy':
      return Colors.pink.shade300;
    case 'Normal':
      return Colors.grey.shade400;
    default:
      return Colors.grey; // Default color if type is unknown
  }
}

Color getPokemonTypeColorType2(String type) {
  switch (type) {
    case 'Normal':
      return Colors.grey.shade500;
    case 'Fire':
      return Colors.orangeAccent;
    case 'Water':
      return Colors.blueAccent;
    case 'Grass':
      return Colors.greenAccent.shade700;
    case 'Electric':
      return Colors.yellow.shade700;
    case 'Ice':
      return Colors.cyanAccent;
    case 'Fighting':
      return Colors.brown.shade700;
    case 'Poison':
      return Colors.purple.shade700;
    case 'Ground':
      return Colors.brown.shade400;
    case 'Flying':
      return Colors.blue.shade300;
    case 'Psychic':
      return Colors.pinkAccent.shade200;
    case 'Bug':
      return Colors.lightGreen.shade700;
    case 'Rock':
      return Colors.grey.shade600;
    case 'Ghost':
      return Colors.deepPurpleAccent;
    case 'Dragon':
      return Colors.indigoAccent;
    case 'Dark':
      return Colors.black87;
    case 'Steel':
      return Colors.blueGrey.shade400;
    case 'Fairy':
      return Colors.pink.shade300;
    default:
      return Colors.grey; // Default color if type is unknown
  }
}
