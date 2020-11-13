// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:basics/basics.dart';

void configureSystemChrome() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      // systemNavigationBarColor: Color.fromRGBO(241, 245, 249, 1),
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.dark));
}

String getDayOfMonthSuffix(final int n) {
  if (n >= 11 && n <= 13) {
    return "th";
  }
  switch (n % 10) {
    case 1:
      return "st";
    case 2:
      return "nd";
    case 3:
      return "rd";
    default:
      return "th";
  }
}

String getMonth(int month) {
  const monthNames = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sept",
    "Oct",
    "Nov",
    "Dec"
  ];
  return monthNames[month - 1];
}

Route<BuildContext> getRouteFromSetting(
    Map<String, WidgetBuilder> routes, RouteSettings settings) {
  final builder = routes[settings.name];
  if (builder.isNotNull) {
    return new MaterialPageRoute(
      settings: settings,
      builder: builder,
    );
  }
  return null;
}
