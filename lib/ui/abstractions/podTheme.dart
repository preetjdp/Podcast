import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PodDesign {
  double size1 = 100;
  double size2 = 80;
  double size3 = 46;
  double size4 = 36;
  double size5 = 28;
  double size6 = 18;
  double size7 = 14;
  double size8 = 12;
  double size9 = 8;

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
            fontSize: podDesign.size1,
            fontWeight: FontWeight.bold,
            color: podDesign.podGrey2),
        headline2: TextStyle(
            fontSize: podDesign.size2,
            fontWeight: FontWeight.bold,
            color: podDesign.podGrey2),
        headline3: TextStyle(
            fontSize: podDesign.size3,
            fontWeight: FontWeight.bold,
            color: podDesign.podGrey2),
        headline4: TextStyle(
            fontSize: podDesign.size4,
            fontWeight: FontWeight.bold,
            color: podDesign.podGrey2),
        headline5: TextStyle(
            fontSize: podDesign.size6,
            fontWeight: FontWeight.w600,
            color: podDesign.podGrey2),
        headline6: TextStyle(
            fontSize: podDesign.size7,
            fontWeight: FontWeight.bold,
            color: podDesign.podGrey2),
        subtitle1: TextStyle(
            fontSize: podDesign.size7,
            fontWeight: FontWeight.w600,
            color: podDesign.podGrey2),
        subtitle2: TextStyle(
            fontSize: podDesign.size8,
            fontWeight: FontWeight.bold,
            color: podDesign.podGrey2),
        bodyText1: TextStyle(
            fontSize: podDesign.size6,
            fontWeight: FontWeight.normal,
            color: podDesign.podGrey2),
        bodyText2: TextStyle(
            fontSize: podDesign.size7,
            fontWeight: FontWeight.normal,
            color: podDesign.podGrey2),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: podDesign.podGrey1,
        inactiveTrackColor: podDesign.podGrey1.withOpacity(0.6),
        overlayColor: podDesign.podGrey1.withOpacity(0.3),
        overlayShape: RoundSliderOverlayShape(overlayRadius: podDesign.size8),
        thumbColor: Colors.white,
        thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: podDesign.size9,
        ),
        trackHeight: 2,
      ));
}
