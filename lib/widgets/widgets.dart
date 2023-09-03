import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Wallpaper",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontFamily: GoogleFonts.overpass().fontFamily,
        ),
      ),
      Text(
        "Hub",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontFamily: GoogleFonts.overpass().fontFamily),
      )
    ],
  );
}
