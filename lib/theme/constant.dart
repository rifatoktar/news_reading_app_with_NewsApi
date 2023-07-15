import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryTextColor = Colors.white.withOpacity(.7);
Color primaryColor = Colors.white.withOpacity(.7);
Color secondaryTextColor = Colors.white.withOpacity(.5);
Color blackColor = Colors.black;
Color buttonColor = Colors.white.withOpacity(.7);
Color activeTabColor = Colors.black;
Color inactiveTabColor = Color(0xffd9d9d9);

class Constant {
  static TextStyle mainHeader = GoogleFonts.lato(
      color: primaryTextColor, fontWeight: FontWeight.bold, fontSize: 40);
  static TextStyle signInText = GoogleFonts.lato(
      color: blackColor, fontWeight: FontWeight.w500, fontSize: 20);
  static TextStyle signInText2 = GoogleFonts.lato(
      color: primaryTextColor, fontWeight: FontWeight.w500, fontSize: 15);
  static TextStyle nameText = GoogleFonts.lato(
      color: primaryTextColor, fontWeight: FontWeight.bold, fontSize: 15);
  static TextStyle helloText = GoogleFonts.lato(
      color: primaryTextColor, fontWeight: FontWeight.w500, fontSize: 12);
  static TextStyle searchText = GoogleFonts.lato(
      color: primaryTextColor, fontWeight: FontWeight.w600, fontSize: 15);
  static TextStyle tabHeaderText =
      GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 15);
  static TextStyle homeNewsHeaderText = GoogleFonts.lato(
      color: primaryTextColor, fontWeight: FontWeight.bold, fontSize: 15);
  static TextStyle homeSubHeaderText = GoogleFonts.lato(
      color: secondaryTextColor, fontWeight: FontWeight.w500, fontSize: 12);
  static TextStyle detailHeaderText = GoogleFonts.lato(
      color: primaryTextColor, fontWeight: FontWeight.bold, fontSize: 20);
  static TextStyle detailAuthorText = GoogleFonts.lato(
      color: secondaryTextColor, fontWeight: FontWeight.w500, fontSize: 12);
  static TextStyle detailSubHeaderText = GoogleFonts.lato(
      color: primaryTextColor, fontWeight: FontWeight.bold, fontSize: 15);
  static TextStyle detailMainText = GoogleFonts.lato(
      color: secondaryTextColor, fontWeight: FontWeight.w600, fontSize: 12);
  static TextStyle errorText = GoogleFonts.lato(
      color: primaryTextColor, fontWeight: FontWeight.bold, fontSize: 15);
}
