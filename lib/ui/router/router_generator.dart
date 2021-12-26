
import 'package:findcaption/ui/router/route_list.dart';
import 'package:findcaption/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class RouterGenerator {

  /// Initializing route
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      /// Home group
      case routeHome:
        return MaterialPageRoute(builder: (_) => const HomeScreen(), settings: const RouteSettings(name: routeHome));
    }
  }
}