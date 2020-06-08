import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PodDesign {
  double fontSizeH1 = 100;
  double fontSizeH2 = 80;
  double fontSizeH3 = 46;
  double fontSizeH4 = 36;
  double fontSizeH5 = 18;
  double fontSizeH6 = 14;

  Color podWhite = Color.fromRGBO(241, 245, 249, 1);
  Color podGrey1 = Color.fromRGBO(28, 35, 52, 1);
  //Color podGrey1 = Color.fromRGBO(52, 59, 70, 1);
  Color podGrey2 = Color.fromRGBO(78, 80, 88, 1);

  Radius podRadius = Radius.circular(8);
}

ThemeData podTheme() {
  PodDesign podDesign = PodDesign();
  return ThemeData(
      fontFamily: "Aileron",
      scaffoldBackgroundColor: podDesign.podWhite,
      backgroundColor: podDesign.podWhite,
      accentColor: podDesign.podGrey1,
      cupertinoOverrideTheme:
          CupertinoThemeData(primaryColor: podDesign.podGrey1),
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: podDesign.fontSizeH1,
            fontWeight: FontWeight.bold,
            color: podDesign.podGrey2),
        headline2: TextStyle(
            fontSize: podDesign.fontSizeH2,
            fontWeight: FontWeight.bold,
            color: podDesign.podGrey2),
        headline3: TextStyle(
            fontSize: podDesign.fontSizeH3,
            fontWeight: FontWeight.bold,
            color: podDesign.podGrey2),
        headline4: TextStyle(
            fontSize: podDesign.fontSizeH4,
            fontWeight: FontWeight.bold,
            color: podDesign.podGrey2),
        headline5: TextStyle(
            fontSize: podDesign.fontSizeH5,
            fontWeight: FontWeight.bold,
            color: podDesign.podGrey2),
        headline6: TextStyle(
            fontSize: podDesign.fontSizeH6,
            fontWeight: FontWeight.bold,
            color: podDesign.podGrey2),
        subtitle1: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: podDesign.podGrey2),
        subtitle2: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: podDesign.podGrey2),
        bodyText1: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.normal,
            color: podDesign.podGrey2),
        bodyText2: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: podDesign.podGrey2),
      ));
}
