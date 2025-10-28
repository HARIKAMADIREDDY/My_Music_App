import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/now_playing_screen.dart';

class Routes {
  static const String home = '/';
  static const String now = '/now';

  static Map<String, WidgetBuilder> get map => {
    home: (_) => const HomeScreen(),
    now: (_) => const NowPlayingScreen(),
  };
}
