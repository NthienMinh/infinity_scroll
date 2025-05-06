import 'package:flutter/material.dart';
import 'package:infinity_scroll/screens/products_screen.dart';

class Routes {
  static const mainScreen = "/";

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (context) => ProductsScreen());
    }
    return null;
  }
}