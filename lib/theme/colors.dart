import 'package:flutter/material.dart';

//////////////// COLORS  //////////////////////////////

const primaryColor = Color.fromRGBO(13, 71, 161, 1);
const primaryFocusColor = Color.fromRGBO(187, 222, 251, 1);
const gradientFocusColor = Color.fromRGBO(203, 203, 203, 0.2);
const secondaryColor = Colors.white;
const black = Colors.black;
const alertColor = Colors.red;

const transparent = Colors.transparent;
const mediumBlue = Color.fromRGBO(62, 119, 193, 1);
const pink = Color.fromRGBO(178, 33, 146, 1);
const darkBlue = Color.fromRGBO(19, 13, 132, 1);
const bronze = Color.fromRGBO(153, 105, 83, 1);
const silver = Color.fromRGBO(120, 118, 118, 1);
const gold = Color.fromRGBO(226, 143, 14, 1);
const warning = Colors.amber;

const veryDarkBlue = Color.fromRGBO(0, 0, 0, 1);
const mediumDarkBlue = Color.fromRGBO(0, 31, 59, 1);
const mediumGrey = Color.fromRGBO(154, 150, 150, 1);
const lightGrey = Color.fromRGBO(243, 243, 243, 1);

const LinearGradient primaryGradient = LinearGradient(
  begin: AlignmentGeometry.bottomCenter,
  end: AlignmentGeometry.topCenter,

  colors: [Color.fromRGBO(231, 231, 231, 1), Color.fromRGBO(158, 158, 158, 1)],
);
const secondaryGradient = LinearGradient(
  begin: AlignmentGeometry.bottomCenter,
  end: AlignmentGeometry.topCenter,
  colors: [Color.fromRGBO(19, 13, 132, 1), Color.fromRGBO(1, 9, 75, 1)],
);
final greyGradient = LinearGradient(
  colors: [Colors.white, Colors.grey.shade300],
);

//////////////// BOXSHADOWS  //////////////////////////////

final defaultShadow = const [
  BoxShadow(
    color: mediumGrey,
    offset: Offset(0, 1),
    blurRadius: 0.5,
    spreadRadius: 0.5,
  ),
  BoxShadow(
    color: mediumGrey,
    offset: Offset(0, -1),
    blurRadius: 0.5,
    spreadRadius: 0.5,
  ),
];

List<BoxShadow> lightShadow = [
  BoxShadow(
    color: primaryFocusColor,
    offset: Offset(1, 3),
    blurRadius: 0.5,
    spreadRadius: 0.5,
  ),
  BoxShadow(
    color: primaryFocusColor,
    offset: Offset(-1, 3),
    blurRadius: 0.5,
    spreadRadius: 0.5,
  ),
];

List<BoxShadow> mediumShadow = [
  BoxShadow(
    color: mediumBlue,
    offset: Offset(0, 1),
    blurRadius: 0.5,
    spreadRadius: 0.5,
  ),
  BoxShadow(
    color: mediumBlue,
    offset: Offset(0, -1),
    blurRadius: 0.5,
    spreadRadius: 0.5,
  ),
];
