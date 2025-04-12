import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_/pokemon.dart';
import 'package:pokedex_/variables.dart';
import 'package:google_fonts/google_fonts.dart';

void bottomModalSheet(BuildContext context, WidgetRef ref) {
  List<String> radio = [
    "Alphabetical",
    "HP",
    "Attack",
    "Defense",
    "Speed",
    "SpecialAttack",
    "SpecialDefense",
    "Default",
  ];

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final buttonSelected = ref.watch(buttonSelectionProvider);

          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),

                child: Column(
                  children: [
                    SizedBox(height: 16),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.055,
                      child: ListTile(
                        title: Text(
                          "Alphabetical",
                          style: GoogleFonts.dotGothic16(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        leading: Radio(
                          activeColor: Colors.blueAccent,
                          value: radio[0],
                          groupValue: varGlobal.currentOption,
                          onChanged: (val) {
                            buttonSelected == 0
                                ? ref
                                    .read(pokemonListProvider.notifier)
                                    .sortAlphabeticalAscending()
                                : ref
                                    .read(pokemonListProvider.notifier)
                                    .sortAlphabeticalDescending();
                            setState(() {
                              varGlobal.currentOption = val.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.055,

                      child: ListTile(
                        title: Text(
                          "HP",
                          style: GoogleFonts.dotGothic16(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        leading: Radio(
                          activeColor: Colors.blueAccent,

                          value: radio[1],
                          groupValue: varGlobal.currentOption,
                          onChanged: (val) {
                            buttonSelected == 0
                                ? ref
                                    .read(pokemonListProvider.notifier)
                                    .sortHPAscending()
                                : ref
                                    .read(pokemonListProvider.notifier)
                                    .sortHPDescending();

                            setState(() {
                              varGlobal.currentOption = val.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.055,

                      child: ListTile(
                        title: Text(
                          "Attack",
                          style: GoogleFonts.dotGothic16(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        leading: Radio(
                          activeColor: Colors.blueAccent,

                          value: radio[2],
                          groupValue: varGlobal.currentOption,
                          onChanged: (val) {
                            buttonSelected == 0
                                ? ref
                                    .read(pokemonListProvider.notifier)
                                    .sortAttackAscending()
                                : ref
                                    .read(pokemonListProvider.notifier)
                                    .sortAttackDescending();
                            setState(() {
                              varGlobal.currentOption = val.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.055,

                      child: ListTile(
                        title: Text(
                          "Defense",
                          style: GoogleFonts.dotGothic16(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        leading: Radio(
                          activeColor: Colors.blueAccent,

                          value: radio[3],
                          groupValue: varGlobal.currentOption,

                          onChanged: (val) {
                            buttonSelected == 0
                                ? ref
                                    .read(pokemonListProvider.notifier)
                                    .sortDefenseAscending()
                                : ref
                                    .read(pokemonListProvider.notifier)
                                    .sortDefenseDescending();

                            setState(
                              () => varGlobal.currentOption = val.toString(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.055,

                      child: ListTile(
                        title: Text(
                          "Speed",
                          style: GoogleFonts.dotGothic16(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        leading: Radio(
                          activeColor: Colors.blueAccent,

                          value: radio[4],
                          groupValue: varGlobal.currentOption,
                          onChanged: (val) {
                            buttonSelected == 0
                                ? ref
                                    .read(pokemonListProvider.notifier)
                                    .sortSpeedAscending()
                                : ref
                                    .read(pokemonListProvider.notifier)
                                    .sortSpeedDescending();
                            setState(
                              () => varGlobal.currentOption = val.toString(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.055,

                      child: ListTile(
                        title: Text(
                          "Special-Attack",
                          style: GoogleFonts.dotGothic16(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        leading: Radio(
                          activeColor: Colors.blueAccent,

                          value: radio[5],
                          groupValue: varGlobal.currentOption,

                          onChanged: (val) {
                            buttonSelected == 0
                                ? ref
                                    .read(pokemonListProvider.notifier)
                                    .sortSpecialAttackAscending()
                                : ref
                                    .read(pokemonListProvider.notifier)
                                    .sortSpecialAttackDescending();

                            setState(
                              () => varGlobal.currentOption = val.toString(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.055,

                      child: ListTile(
                        title: Text(
                          "Special-Defense",
                          style: GoogleFonts.dotGothic16(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        leading: Radio(
                          activeColor: Colors.blueAccent,

                          value: radio[6],
                          groupValue: varGlobal.currentOption,
                          onChanged: (val) {
                            buttonSelected == 0
                                ? ref
                                    .read(pokemonListProvider.notifier)
                                    .sortSpecialDefenseAscending()
                                : ref
                                    .read(pokemonListProvider.notifier)
                                    .sortSpecialDefenseDescending();
                            setState(
                              () => varGlobal.currentOption = val.toString(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.055,

                      child: ListTile(
                        title: Text(
                          "Default",
                          style: GoogleFonts.dotGothic16(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        leading: Radio(
                          activeColor: Colors.blueAccent,

                          value: radio[7],
                          groupValue: varGlobal.currentOption,
                          onChanged: (val) {
                            buttonSelected == 0
                                ? ref
                                    .read(pokemonListProvider.notifier)
                                    .orginalState()
                                : ref
                                    .read(pokemonListProvider.notifier)
                                    .orginalStateReverse();
                            setState(
                              () => varGlobal.currentOption = val.toString(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        SizedBox(width: 16),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.06,

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              side:
                                  buttonSelected == 0
                                      ? BorderSide(color: Colors.blueAccent)
                                      : BorderSide(color: Colors.transparent),
                              backgroundColor:
                                  buttonSelected == 0
                                      ? const Color.fromARGB(141, 3, 168, 244)
                                      : Colors.transparent,
                            ),
                            onPressed: () {
                              ref
                                  .read(buttonSelectionProvider.notifier)
                                  .setAnother(0);

                              setAscending(
                                radio.indexOf(varGlobal.currentOption),
                                ref,
                              );
                            },
                            child: Text(
                              "Ascending",
                              style: GoogleFonts.pressStart2p(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.0285,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              side:
                                  buttonSelected == 1
                                      ? BorderSide(color: Colors.blueAccent)
                                      : BorderSide(color: Colors.transparent),
                              backgroundColor:
                                  buttonSelected == 1
                                      ? const Color.fromARGB(141, 3, 168, 244)
                                      : Colors.transparent,
                            ),
                            onPressed: () {
                              ref
                                  .read(buttonSelectionProvider.notifier)
                                  .setAnother(1);

                              setDescending(
                                radio.indexOf(varGlobal.currentOption),
                                ref,
                              );
                            },
                            child: Text(
                              "Descending",
                              style: GoogleFonts.pressStart2p(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.027,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
  );
}

void setAscending(int index, WidgetRef ref) {
  switch (index) {
    case 0:
      ref.read(pokemonListProvider.notifier).sortAlphabeticalAscending();
      break;

    case 1:
      ref.read(pokemonListProvider.notifier).sortHPAscending();
      break;

    case 2:
      ref.read(pokemonListProvider.notifier).sortAttackAscending();
      break;

    case 3:
      ref.read(pokemonListProvider.notifier).sortDefenseAscending();
      break;

    case 4:
      ref.read(pokemonListProvider.notifier).sortSpeedAscending();
      break;

    case 5:
      ref.read(pokemonListProvider.notifier).sortSpecialAttackAscending();
      break;

    case 6:
      ref.read(pokemonListProvider.notifier).sortSpecialDefenseAscending();
      break;

    case 7:
      ref.read(pokemonListProvider.notifier).orginalState();
      break;
  }
}

void setDescending(int index, WidgetRef ref) {
  switch (index) {
    case 0:
      ref.read(pokemonListProvider.notifier).sortAlphabeticalDescending();
      break;

    case 1:
      ref.read(pokemonListProvider.notifier).sortHPDescending();
      break;

    case 2:
      ref.read(pokemonListProvider.notifier).sortAttackDescending();
      break;

    case 3:
      ref.read(pokemonListProvider.notifier).sortDefenseDescending();
      break;

    case 4:
      ref.read(pokemonListProvider.notifier).sortSpeedDescending();
      break;

    case 5:
      ref.read(pokemonListProvider.notifier).sortSpecialAttackDescending();
      break;

    case 6:
      ref.read(pokemonListProvider.notifier).sortSpecialAttackDescending();
      break;

    case 7:
      ref.read(pokemonListProvider.notifier).orginalStateReverse();
      break;
  }
}
