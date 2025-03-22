import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_/assets/utils/colorreturn.dart';
import 'package:pokedex_/pokemon.dart';
import 'package:pokedex_/assets/utils/statItem.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonInfo extends StatefulWidget {
  final Pokemon obj;

  const PokemonInfo({super.key, required this.obj});

  @override
  State<PokemonInfo> createState() => _PokemonInfoState();
}

Future<String> callLink(String link) async {
  // function used by callLinkLocal inside class, used to just call the link

  http.Response response;

  response = await http.get(Uri.parse(link));

  if (response.statusCode == 200) {
    return response.body;
  }

  return "";
}

class _PokemonInfoState extends State<PokemonInfo> {
  int? weight;
  int? height;
  String? desc;

  void callLinkLocal(String name) async {
    String pokemonLink = "https://pokeapi.co/api/v2/pokemon/$name";
    String response = await callLink(pokemonLink);

    if (response != "") {
      Map pokemonMap = jsonDecode(response);
      String responseSpecies = await callLink(pokemonMap['species']['url']);

      setState(() {
        height = pokemonMap['height'];
        weight = pokemonMap['weight'];
      });

      if (responseSpecies != "") {
        Map speciesResponse = jsonDecode(responseSpecies);
        desc = speciesResponse['flavor_text_entries'][0]['flavor_text'];
      }

      setState(() {
        desc = desc?.replaceAll("\n", " ");
      });
    }
  }

  @override
  void initState() {
    callLinkLocal(widget.obj.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        // appBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(""),
        backgroundColor: widget.obj.color!.color,
      ),
      body: Column(
        children: [
          Container(
            // the upper container containing image and heading, container used to add gradient color
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [widget.obj.color!.color, Colors.black45],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.decal,
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Image.network(
                      widget.obj.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
                    child: Text(
                      widget.obj.name,
                      style: GoogleFonts.pressStart2p(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.085,
                        foreground:
                            Paint()
                              ..shader = LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [widget.obj.color!.color, Colors.black],
                              ).createShader(Rect.fromLTWH(0, 0, 0, 50)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                // all children in this
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      // row has two pokemon type properties, both expanded
                      children: [
                        Expanded(
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100),
                                ),
                              ),
                              child: Image.asset(
                                getPokemonTypeImageType1(widget.obj.types1),
                                fit: BoxFit.fill,
                                height: 30,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              getPokemonTypeImageType2(widget.obj.types2),
                              fit: BoxFit.cover,

                              height: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          desc ?? "...",
                          style: GoogleFonts.dotGothic16(fontSize: 15),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: Column(
                              children: [
                                SizedBox(
                                  child: Column(
                                    children: [
                                      singleItem(
                                        context,
                                        desc:
                                            "HP : Determines how much damage a Pokémon can take before fainting. A higher HP means better survivability in battles.”",
                                        color: Color.fromARGB(153, 255, 82, 82),
                                        icon: Icons.healing,
                                        val: widget.obj.hp,
                                      ),
                                      singleItem(
                                        context,
                                        desc:
                                            " ATTACK : Controls the strength of physical moves. Pokémon with high Attack deal more damage with direct-contact moves like punches and kicks.",
                                        color: const Color.fromARGB(
                                          222,
                                          255,
                                          165,
                                          48,
                                        ),
                                        icon: Icons.flash_on,
                                        val: widget.obj.attack,
                                      ),
                                      singleItem(
                                        context,
                                        desc:
                                            "DEFENSE: Reduces damage taken from physical attacks. A strong Defense helps withstand powerful hits from physical moves.",
                                        color: const Color.fromARGB(
                                          204,
                                          33,
                                          149,
                                          243,
                                        ),
                                        icon: Icons.health_and_safety,
                                        val: widget.obj.defense,
                                      ),
                                      singleItem(
                                        context,
                                        desc:
                                            "HEIGHT :Defines the Pokemon's physical stature. Taller Pokemon may have extended reach, while smaller ones can be harder to hit.",
                                        color: Colors.green,
                                        icon: Icons.height,
                                        val: height ?? 0,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              singleItem(
                                context,
                                desc:
                                    "SPEED : Decides which Pokémon moves first in battle. A higher Speed can give a crucial advantage in fast-paced fights",
                                color: const Color.fromARGB(214, 255, 235, 59),
                                icon: Icons.speed,
                                val: widget.obj.speed,
                              ),
                              singleItem(
                                context,
                                desc:
                                    "SPECIAL-ATTACK :Determines the power of special moves like fire blasts and energy beams. High Sp. Atk Pokemon excel in non-contact attacks",
                                color: const Color.fromARGB(149, 223, 64, 251),
                                icon: Icons.star,
                                val: widget.obj.spAttack,
                              ),
                              singleItem(
                                context,
                                desc:
                                    "SPECIAL-DEFENSE :Reduces damage from special attacks like psychic waves and elemental blasts. A strong Sp. Def helps against magical or ranged moves.",
                                color: Colors.teal,
                                icon: Icons.security,
                                val: widget.obj.spDefense,
                              ),
                              singleItem(
                                context,
                                desc:
                                    "WEIGHT : Affects certain moves and abilities. Heavier Pokemon may hit harder but can be slower, while lighter ones are often more agile",
                                color: Colors.brown,
                                icon: Icons.monitor_weight,
                                val: weight ?? 0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
