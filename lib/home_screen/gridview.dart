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
  String startCallLink = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0";

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
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(5),
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
                              mapresponse.isEmpty
                                  ? Text("")
                                  : Text(
                                    mapresponse['results'][index]['name'][0]
                                            .toUpperCase() +
                                        mapresponse['results'][index]['name']
                                            .substring(1),
                                    style: TextStyle(fontSize: 24),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
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
                              types1.length >= index + 1
                                  ? Text(
                                    types1[index][0].toUpperCase() +
                                        types1[index].substring(1),
                                    style: TextStyle(fontSize: 18),
                                  )
                                  : Text(""),
                              SizedBox(width: 10),
                              types1.length >= index + 1
                                  ? Text(
                                    types2[index].length > 2
                                        ? types2[index][0].toUpperCase() +
                                            types2[index].substring(1)
                                        : "",
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
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 150,
                    width: 120,
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
