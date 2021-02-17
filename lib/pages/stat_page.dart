import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:games_app/models/stat.dart';
import 'package:games_app/pages/add_stat_page.dart';
import 'package:games_app/services/game_stats_service.dart';
import 'package:provider/provider.dart';

class StatPage extends StatefulWidget {
  @override
  _StatPageState createState() => _StatPageState();
}

class _StatPageState extends State<StatPage>
    with AutomaticKeepAliveClientMixin {
  GameStatsService service;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      fetchCategories();
    });
  }

  void fetchCategories() async {
    await service.getCategories();
    setState(() {
      isLoading = false;
    });
    await service.getStats();
  }

  @override
  Widget build(BuildContext context) {
    service = Provider.of<GameStatsService>(context);
    super.build(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        heroTag: 'stat',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AddStatPage()),
          );
        },
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: service.categories.length,
              itemBuilder: (context, index) {
                List<Stat> stats =
                    service.stats[service.categories[index].name];
                return Card(
                  child: ExpansionTile(
                    title: Text(service.categories[index].name),
                    children: stats == null
                        ? [Container()]
                        : [
                            ListView.builder(
                              itemCount: stats.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => ListTile(
                                leading: CircleAvatar(
                                  child: Text('${index + 1}'),
                                ),
                                title: Text(stats[index].name),
                                subtitle: Text('${stats[index].score}'),
                              ),
                            )
                          ],
                  ),
                );
              },
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// stats
//                             .map(
//                               (e) => ListTile(
//                                 leading: CircleAvatar(
//                                   child: Text('${index + 1}'),
//                                 ),
//                                 title: Text(e.name),
//                                 subtitle: Text('${e.score}'),
//                               ),
//                             )
//                             .toList()
