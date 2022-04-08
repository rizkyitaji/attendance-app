import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color red = Colors.red;
Color white = Colors.white;
Color black = Colors.black;
Color blue = Color(0xFF315FB8);
Color grey = Color(0xFFBDC3C7);

TextStyle poppinsWhitew600 = GoogleFonts.poppins(
  fontWeight: FontWeight.w600,
  color: white,
);
TextStyle poppinsBlackw600 = GoogleFonts.poppins(
  fontWeight: FontWeight.w600,
  color: black,
);

TextStyle poppinsBluew600 = GoogleFonts.poppins(
  fontWeight: FontWeight.w600,
  color: blue,
);

TextStyle poppinsBlackw400 = GoogleFonts.poppins(
  fontWeight: FontWeight.w400,
  color: black,
);

TextStyle poppinsWhitew300 = GoogleFonts.poppins(
  fontWeight: FontWeight.w300,
  color: white,
);

TextStyle poppinsWhitew500 = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: white,
);

TextStyle poppinsBluew500 = GoogleFonts.poppins(
  fontWeight: FontWeight.w500,
  color: blue,
);

double width(BuildContext context) => MediaQuery.of(context).size.width;
double height(BuildContext context) => MediaQuery.of(context).size.height;
