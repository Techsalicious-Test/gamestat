import 'package:flutter/material.dart';
import 'package:games_app/game_stat.dart';
import 'package:games_app/pages/splash_page.dart';
import 'package:games_app/services/game_stats_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GameStat.preferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GameStatsService>(
          create: (_) => GameStatsService(),
        )
      ],
      child: MaterialApp(
        title: 'Games Stat',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        home: SplashPage(),
      ),
    );
  }
}
