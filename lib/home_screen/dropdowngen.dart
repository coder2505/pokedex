import 'package:flutter/material.dart';

List<String> genList = [
  "All",
  "Indigo League",
  "Orange League",
  "Johto League",
  "Hoenn League",
  "Sinnoh League",
  "Unova League ",
  "Kalos League",
  "Alola League",
  "Galar League",
  "Paldea League",
];

Widget dropDownGen() {
  String? currentop = genList[0];

  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      return DropdownButton<String>(
        isExpanded: true,
        value: currentop,
        style: TextStyle(color: Colors.white, fontSize: 18),
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
            currentop = val;
          });
        },
      );
    },
  );
}
