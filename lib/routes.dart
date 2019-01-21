import 'package:dante/screens/create.dart';
import 'package:dante/screens/home.dart';
import 'package:flutter/material.dart';

final routes = {
  "/": (context) => HomeScreen(),
  "/create": (context) => CreateScreen(),
  "/modals/create": (context) => CreateScreen()
};

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final name = settings.name;
  var fullscreenDialog = false;

  final elements = name.split("/");
  final route = routes[name];

  if (elements[0] != "") return null;

  if (elements[1] == "modals") {
    fullscreenDialog = true;
  }
  
  return MaterialPageRoute(builder: route, fullscreenDialog: fullscreenDialog);
}
