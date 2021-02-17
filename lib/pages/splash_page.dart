import 'package:flutter/material.dart';
import 'package:games_app/game_stat.dart';
import 'package:games_app/pages/root_page.dart';
import 'package:games_app/pages/username_page.dart';
import 'package:games_app/services/game_stats_service.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  GameStatsService gameStatsService;
  @override
  void initState() {
    super.initState();
    String username = GameStat.preferences.getString(GameStat.usernamePref);
    gameStatsService = Provider.of<GameStatsService>(context, listen: false);
    gameStatsService.openDB().then((_) {
      // widget.onLoadingComplete();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => username == null || username.isEmpty
              ? UsernamePage()
              : RootPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
