import 'package:flutter/material.dart';
import 'package:retro_music_player/router/router.dart';
import 'package:retro_music_player/services/navigation_service.dart';
import 'package:retro_music_player/utils/constants.dart';
import 'package:retro_music_player/utils/di.dart';

void main() {
  setupDI();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beginner App',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (context, child) => child,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: HomeRoute,
    );
  }
}
