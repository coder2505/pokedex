import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget singleItem(
  BuildContext context, {
  String? desc,
  int? val,
  IconData? icon,
  Color? color,
}) {
  double padding = MediaQuery.of(context).size.width * 0.12;

  return SizedBox(
    child: Padding(
      padding: EdgeInsets.fromLTRB(padding, 16, 16, 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar() // Dismiss any existing snackbar
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      desc ?? "",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blueGrey,
                    duration: Duration(seconds: 3),
                  ),
                );
            },
            child: Icon(icon, color: color, size: 30),
          ), // Icon
          SizedBox(width: MediaQuery.of(context).size.width * 0.03), // Spacing
          Text(
            val.toString(),
            style: GoogleFonts.pressStart2p(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
