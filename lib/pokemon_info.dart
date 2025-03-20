import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_/utils/colorreturn.dart';
import 'package:pokedex_/pokemon.dart';
import 'package:pokedex_/utils/statItem.dart';

class PokemonInfo extends StatefulWidget {
  final Pokemon obj;

  const PokemonInfo({super.key, required this.obj});

  @override
  State<PokemonInfo> createState() => _PokemonInfoState();
}

Future<String> callLink(String name) async {
  String pokemonLink = "https://pokeapi.co/api/v2/pokemon/" + name;

  http.Response response;

  response = await http.get(Uri.parse(pokemonLink));

  if (response.statusCode == 200) {
    return response.body;
  }

  return "";
}

class _PokemonInfoState extends State<PokemonInfo> {
  int? weight;
  int? height;

  void callLinkLocal(String name) async {
    String response = await callLink(name);

    if (response != "") {
      Map pokemonMap = jsonDecode(response);
      setState(() {
        height = pokemonMap['height'];
        weight = pokemonMap['weight'];
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
        title: const Text(""),
        backgroundColor: widget.obj.color!.color,
      ),
      body: Column(
        children: [
          Container(
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
                SizedBox(height: 10),

                Center(
                  child: Text(
                    widget.obj.name,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
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
                SizedBox(height: 50),
              ],
            ),
          ),

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
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              widget.obj.types1,
                              style: TextStyle(
                                fontSize: 20,
                                color: getPokemonTypeColorType1(
                                  widget.obj.types1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              widget.obj.types2,
                              style: TextStyle(
                                fontSize: 20,
                                color: getPokemonTypeColorType2(
                                  widget.obj.types2,
                                ),
                              ),
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
                    height: MediaQuery.of(context).size.height * 0.4,
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
