import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex_/pokemon.dart';
import 'package:pokedex_/variables.dart';

final List<String> genList = [
  // DO NOT TOUCH THIS
  "All",
  "Indigo League",
  "Johto League",
  "Hoenn League",
  "Sinnoh League",
  "Unova League",
  "Kalos League",
  "Alola League",
  "Galar League",
  "Paldea League",
];

Widget dropDownGen(WidgetRef ref) {
  varGlobal.currentOptionGen = genList[0];

  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      return DropdownButton<String>(
        isExpanded: true,
        value: varGlobal.currentOptionGen,
        style: GoogleFonts.dotGothic16(
          fontSize: MediaQuery.of(context).size.width * 0.05,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        underline: Container(color: Colors.transparent),
        items:
            genList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(child: Text(value)),
              );
            }).toList(),
        onChanged: (val) {
          setState(() {
            varGlobal.currentOptionGen = val;

            switch (val) {
              case "All":
                ref.watch(pokemonListProvider.notifier).setnewLimit(0, 1025);
                break;

              case "Indigo League":
                int offset = varGlobal.startIndexOfLeagues[0];
                int limit = varGlobal.endIndexOfLeagues[0];

                ref
                    .watch(pokemonListProvider.notifier)
                    .setnewLimit(offset, limit);
                break;

              case "Johto League":
                int offset = varGlobal.startIndexOfLeagues[1];
                int limit = varGlobal.endIndexOfLeagues[1];
                ref
                    .watch(pokemonListProvider.notifier)
                    .setnewLimit(offset, limit);
                break;

              case "Hoenn League":
                int offset = varGlobal.startIndexOfLeagues[2];
                int limit = varGlobal.endIndexOfLeagues[2];
                ref
                    .watch(pokemonListProvider.notifier)
                    .setnewLimit(offset, limit);
                break;

              case "Sinnoh League":
                int offset = varGlobal.startIndexOfLeagues[3];
                int limit = varGlobal.endIndexOfLeagues[3];
                ref
                    .read(pokemonListProvider.notifier)
                    .setnewLimit(offset, limit);
                break;

              case "Unova League":
                int offset = varGlobal.startIndexOfLeagues[4];
                int limit = varGlobal.endIndexOfLeagues[4];
                ref
                    .read(pokemonListProvider.notifier)
                    .setnewLimit(offset, limit);
                break;

              case "Kalos League":
                int offset = varGlobal.startIndexOfLeagues[5];
                int limit = varGlobal.endIndexOfLeagues[5];
                ref
                    .read(pokemonListProvider.notifier)
                    .setnewLimit(offset, limit);
                break;

              case "Alola League":
                int offset = varGlobal.startIndexOfLeagues[6];
                int limit = varGlobal.endIndexOfLeagues[6];
                ref
                    .read(pokemonListProvider.notifier)
                    .setnewLimit(offset, limit);
                break;

              case "Galar League":
                int offset = varGlobal.startIndexOfLeagues[7];
                int limit = varGlobal.endIndexOfLeagues[7];
                ref
                    .read(pokemonListProvider.notifier)
                    .setnewLimit(offset, limit);
                break;

              case "Paldea League":
                int offset = varGlobal.startIndexOfLeagues[8];
                int limit = varGlobal.endIndexOfLeagues[8];
                ref
                    .read(pokemonListProvider.notifier)
                    .setnewLimit(offset, limit);
                break;
            }
          });
        },
      );
    },
  );
}
