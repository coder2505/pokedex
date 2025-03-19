import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_/pokemon.dart';

class GridViewHomeScreen extends ConsumerStatefulWidget {
  const GridViewHomeScreen({super.key});

  @override
  ConsumerState<GridViewHomeScreen> createState() => _GridViewHomeScreenState();
}

class _GridViewHomeScreenState extends ConsumerState<GridViewHomeScreen> {
  Map mapresponse = {};

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

      for (int i = 0; i < 1025; i++) {
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

          int hp = pokemonMap['stats'][0]['base_stat'];
          int attack = pokemonMap['stats'][1]['base_stat'];
          int defense = pokemonMap['stats'][2]['base_stat'];
          int specialAttack = pokemonMap['stats'][3]['base_stat'];
          int specialDefense = pokemonMap['stats'][4]['base_stat'];
          int speed = pokemonMap['stats'][5]['base_stat'];

          colorForPokemon(imageUrl, i);

          setState(() {
            ref
                .read(pokemonListProvider.notifier)
                .add(
                  Pokemon(
                    name: name,
                    types1: types1,
                    types2: types2,
                    imageUrl: imageUrl,
                    hp: hp,
                    attack: attack,
                    defense: defense,
                    spAttack: specialAttack,
                    spDefense: specialDefense,
                    speed: speed,
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
          size: Size(20, 20), // Resize image for faster processing
        );

    try {
      ref
          .read(pokemonListProvider.notifier)
          .addColor(paletteGenerator.dominantColor, index);
    } catch (e) {
      ref
          .read(pokemonListProvider.notifier)
          .addColor(PaletteColor(Colors.blueGrey, 10), index);
    }
  }

  @override
  void initState() {
    startCallLink = "https://pokeapi.co/api/v2/pokemon?limit=1025&offset=0";

    calle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(pokemonListProvider);
    // ref.watch(filteredPokemonProvider);
    // ref.watch(limitProvider);

    // int offset = ref.watch(limitProvider.notifier).getOffset();
    // int limit = ref.watch(limitProvider.notifier).getLimit();

    return GridView.builder(
      itemCount: ref.watch(pokemonListProvider.notifier).length(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2.75,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        int length = ref.read(pokemonListProvider.notifier).length();

        List<Pokemon> pokemonObj = ref.watch(pokemonListProvider);

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                length >= index + 1 && pokemonObj[index].color != null
                    ? pokemonObj[index].color!.color
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
                              length >= index + 1
                                  ? Text(
                                    pokemonObj[index].name,
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
                              length >= index + 1
                                  ? Text(
                                    pokemonObj[index].types1,
                                    style: TextStyle(fontSize: 18),
                                  )
                                  : Text(""),
                              SizedBox(width: 10),
                              length >= index + 1
                                  ? Text(
                                    pokemonObj[index].types2,
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
                        length >= index + 1
                            ? Image.network(
                              pokemonObj[index].imageUrl,
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
