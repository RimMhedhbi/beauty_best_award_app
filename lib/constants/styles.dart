import 'dart:ui';
import 'package:flutter/material.dart';

//Colors
class appColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color orange = Color.fromRGBO(251, 176, 64, 1);
}

const openSansFont = "OpenSans";

//FontWeight
const FontWeight lightFont = FontWeight.w300;
const FontWeight extraLightFont = FontWeight.w200;
const FontWeight regularFont = FontWeight.w400;
const FontWeight mediumFont = FontWeight.w500;
const FontWeight semiBoldFont = FontWeight.w600;
const FontWeight boldFont = FontWeight.w700;

//FontStyle

const openSansFont25ptWhite = TextStyle(
  fontFamily: openSansFont,
  fontWeight: FontWeight.w600,
  fontSize: 25,
  color: appColors.white,
);

const openSansFont25ptOrange = TextStyle(
  fontFamily: openSansFont,
  fontWeight: FontWeight.w600,
  fontSize: 25,
  color: appColors.orange,
);


const openSansFont8ptBlack = TextStyle(
    fontFamily: openSansFont,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: 8);

const openSansFont12ptBlack = TextStyle(
    fontFamily: openSansFont,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: 12);

const openSansFont16ptBlack = TextStyle(
    fontFamily: openSansFont,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: 16);

const openSansFont20ptBlack = TextStyle(
    fontFamily: openSansFont,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: 20);

const openSansFont25ptBlack = TextStyle(
    fontFamily: openSansFont,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: 25);

const openSansFont30ptBlack = TextStyle(
    fontFamily: openSansFont,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: 30);

const openSansFont30ptWhite = TextStyle(
    fontFamily: openSansFont,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontSize: 30);
