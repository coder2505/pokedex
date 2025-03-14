import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GridViewHomeScreen extends StatefulWidget {
  const GridViewHomeScreen({super.key});

  @override
  State<GridViewHomeScreen> createState() => _GridViewHomeScreenState();
}

class _GridViewHomeScreenState extends State<GridViewHomeScreen> {
  Map mapresponse = {};

  List types1 = [];
  List types2 = [];

  String pokemonLink = "https://pokeapi.co/api/v2/pokemon/";
  String startCallLink = "https://pokeapi.co/api/v2/pokemon?limit=20";

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

      for (int i = 0; i < 20; i++) {
        String pokemoninfo = await callLink(
          pokemonLink + mapresponse['results'][i]['name'],
        );

        if (pokemoninfo != "") {
          setState(() {
            Map pokemonMap = jsonDecode(pokemoninfo);
            types1.add(pokemonMap['types'][0]['type']['name']);
            try {
              types2.add(pokemonMap['types'][1]['type']['name']);
            } catch (e) {
              types2.add("");
            }
          });
        }
      }
    }
  }

  @override
  void initState() {
    calle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 20,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2.75,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.black12,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    mapresponse.isEmpty
                        ? Text("")
                        : Text(
                          mapresponse['results'][index]['name'],
                          style: TextStyle(fontSize: 24),
                        ),
                    Row(
                      children: [
                        types1.length >= index + 1
                            ? Text(
                              types1[index],
                              style: TextStyle(fontSize: 18),
                            )
                            : Text(""),
                        SizedBox(width: 10),
                        types1.length >= index + 1
                            ? Text("flying", style: TextStyle(fontSize: 18))
                            : Text(""),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(color: Colors.grey, height: 150, width: 120),
              ),
            ],
          ),
        ); // code for
      },
    );
  }
}
