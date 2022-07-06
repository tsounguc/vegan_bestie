import 'package:flutter/material.dart';
import 'package:sheveegan/presentation/vegan_bestie_home.dart';

class AppRouter {
  static const String home = '/';
  final String productFound = 'productdound';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => VeganBestieHome(),
        );
      default:
        throw Exception('Route not found!');
    }
  }
}
