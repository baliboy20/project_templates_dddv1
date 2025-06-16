import 'dart:developer';

import 'package:flutter/material.dart';



import '../../features/home/presentation/screens/screens.dart' as home;

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return home.HomeScreen.genRoute();
      case '/home':
        return home.HomeScreen.genRoute();

        // case GardenBlogScreen.routeName:
        //   return GardenBlogScreen.genRoute();
      default:
        {
          log('error route from default fired ${settings.name}');
          return _errorRoute();
        }
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text(
              'Something went wrong! (has the route been added to AppRouter?)'),
        ),
      ),
    );
  }
}
