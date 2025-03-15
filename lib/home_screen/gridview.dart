import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_/pokemon.dart';

class GridViewHomeScreen extends StatefulWidget {
  const GridViewHomeScreen({super.key});

  @override
  State<GridViewHomeScreen> createState() => _GridViewHomeScreenState();
}

class _GridViewHomeScreenState extends State<GridViewHomeScreen> {
  Map mapresponse = {};

  int limit = 10000;

  List<Pokemon> pokemonList = [];

  String pokemonLink = "https://pokeapi.co/api/v2/pokemon/";
  String startCallLink = "https://pokeapi.co/api/v2/pokemon?limit=&offset=0";

  Future<String> callLink(String link) async {
    http.Response response;

    response = await http.get(Uri.parse(link));

    if (response.statusCode == 200) {
      return response.body;
    }

    return "";
  }

  void calle() async {
    String response = await callLink(startCallLink);

    if (response != "") {
      setState(() {
        mapresponse = jsonDecode(response);
      });

      for (int i = 0; i < limit; i++) {
        String pokemoninfo = await callLink(
          pokemonLink + mapresponse['results'][i]['name'],
        );

        if (pokemoninfo != "") {
          Map pokemonMap = jsonDecode(pokemoninfo);

          String name =
              pokemonMap['name'][0].toUpperCase() +
              pokemonMap['name'].substring(1);
          String types1 =
              pokemonMap['types'][0]['type']['name'][0].toUpperCase() +
              pokemonMap['types'][0]['type']['name'].substring(1);
          String imageUrl = pokemonMap['sprites']['front_default'];
          String types2 = "";
          try {
            types2 =
                pokemonMap['types'][1]['type']['name'][0].toUpperCase() +
                pokemonMap['types'][1]['type']['name'].substring(1);
          } catch (e) {
            types2 = "";
          }

          colorForPokemon(imageUrl, i);

          setState(() {
            pokemonList.add(
              Pokemon(
                name: name,
                types1: types1,
                types2: types2,
                imageUrl: imageUrl,
              ),
            );
          });
        }
      }
    }
  }

  Future colorForPokemon(imageurl, int index) async {
    ImageProvider imageProvider = Image.network(imageurl).image;

    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
          imageProvider,
          size: Size(200, 200), // Resize image for faster processing
        );

    try {
      pokemonList[index].color = (paletteGenerator.dominantColor);
    } catch (e) {
      pokemonList[index].color = (PaletteColor(Colors.blueGrey, 10));
    }
  }

  @override
  void initState() {
    startCallLink = "https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=0";
    calle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: limit,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2.75,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                pokemonList.length >= index + 1 &&
                        pokemonList[index].color != null
                    ? pokemonList[index].color!.color
                    : Colors.black45,
                const Color.fromARGB(255, 58, 58, 58),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              tileMode: TileMode.decal,
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color.fromARGB(29, 255, 255, 255)),
          ),

          child: Row(
            children: [
              // Left side: Name and Types (60% width)
              Expanded(
                flex: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Name section (60% height)
                      Expanded(
                        flex: 60,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child:
                              pokemonList.length >= index + 1
                                  ? Text(
                                    pokemonList[index].name,
                                    style: TextStyle(fontSize: 24),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  )
                                  : Text(""),
                        ),
                      ),
                      // Types section (40% height)
                      Expanded(
                        flex: 40,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              pokemonList.length >= index + 1
                                  ? Text(
                                    pokemonList[index].types1,
                                    style: TextStyle(fontSize: 18),
                                  )
                                  : Text(""),
                              SizedBox(width: 10),
                              pokemonList.length >= index + 1
                                  ? Text(
                                    pokemonList[index].types2,
                                    style: TextStyle(fontSize: 18),
                                  )
                                  : Text(""),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Right side: Image (40% width)
              Expanded(
                flex: 40,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 150,
                    width: 120,
                    child:
                        pokemonList.length >= index + 1
                            ? Image.network(
                              pokemonList[index].imageUrl,
                              fit: BoxFit.contain,
                            )
                            : SizedBox(),
                  ),
                ),
              ),
            ],
          ),
        ); // code for
      },
    );
  }
}
