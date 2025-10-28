import 'package:flutter/material.dart';
import 'package:my_music_app/screens/home_screen.dart';
import 'routes.dart';
import 'theme/app_theme.dart';
import 'screens/now_playing_screen.dart'; // <-- Make sure you import this file

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Music App (Dark)',
      theme: AppTheme.dark(),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (_) => const HomeScreen(), // if you have a home screen
        '/now': (_) => const NowPlayingScreen(), // ✅ your Now Playing route
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
