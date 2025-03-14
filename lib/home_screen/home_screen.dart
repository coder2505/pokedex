import 'package:flutter/material.dart';
import 'package:pokedex_/home_screen/gridview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pokedex")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridViewHomeScreen(),
      ),
    );
  }
}
