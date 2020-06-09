import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PodDesign {
  double fontSizeH1 = 100;
  double fontSizeH2 = 80;
  double fontSizeH3 = 46;
  double fontSizeH4 = 36;
  double fontSizeH5 = 18;
  double fontSizeH6 = 14;
  double fontSizeH7 = 12;

  Color podWhite1 = Colors.white;
  Color podWhite2 = Color.fromRGBO(247, 247, 247, 1);
  Color podGrey1 = Color.fromRGBO(22, 18, 36, 1);
  //Color podGrey1 = Color.fromRGBO(52, 59, 70, 1);
  Color podGrey2 = Color.fromRGBO(28, 35, 52, 1);

  Radius podRadius = Radius.circular(8);
}

ThemeData podTheme() {
  PodDesign podDesign = PodDesign();
  return ThemeData(
      fontFamily: "Aileron",
      scaffoldBackgroundColor: podDesign.podWhite1,
      backgroundColor: podDesign.podWhite1,
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
            fontWeight: FontWeight.w600,
            color: podDesign.podGrey2),
        headline6: TextStyle(
            fontSize: podDesign.fontSizeH6,
            fontWeight: FontWeight.bold,
            color: podDesign.podGrey2),
        subtitle1: TextStyle(
            fontSize: podDesign.fontSizeH6,
            fontWeight: FontWeight.w600,
            color: podDesign.podGrey2),
        subtitle2: TextStyle(
            fontSize: podDesign.fontSizeH7,
            fontWeight: FontWeight.bold,
            color: podDesign.podGrey2),
        bodyText1: TextStyle(
            fontSize: podDesign.fontSizeH5,
            fontWeight: FontWeight.normal,
            color: podDesign.podGrey2),
        bodyText2: TextStyle(
            fontSize: podDesign.fontSizeH6,
            fontWeight: FontWeight.normal,
            color: podDesign.podGrey2),
      ));
}
