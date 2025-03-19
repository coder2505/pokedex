import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex_/home_screen/bottommodalsheetsort.dart';
import 'package:pokedex_/home_screen/dropdowngen.dart';
import 'package:pokedex_/home_screen/gridview.dart';
import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:pokedex_/pokemon.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String Search = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        clearOnClose: true,
        onClosed: () {
          ref.read(pokemonListProvider.notifier).searchQueryClosed();
        },

        onChanged: (text) {
          Search = text;
          ref.watch(pokemonListProvider.notifier).searchPokemon(Search);
        },

        animation: AppBarAnimationSlideLeft.call,
        appBarBuilder: (BuildContext context) {
          return AppBar(
            title: const Text("Pokedex"),
            actions: [AppBarSearchButton()],
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),

        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              child: Center(child: dropDownGen(ref)),
            ),
            Expanded(child: GridViewHomeScreen()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(207, 0, 0, 0),
        child: Icon(Icons.filter_alt_rounded),
        onPressed: () {
          return bottomModalSheet(context, ref);
        },
      ),
    );
  }
}
