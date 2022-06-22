import 'package:uas_mobile/models/queue.dart';
import 'package:uas_mobile/pages/detail_queue_page.dart';
import 'package:uas_mobile/pages/drawer_nav.dart';
import 'package:uas_mobile/pages/queue_page.dart';
import 'package:uas_mobile/services/queue_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QueueService _queueService;

  List<Antrean> _queueList = <Antrean>[];

  @override
  initState() {
    super.initState();
    getAllQueue();
  }

  getAllQueue() async {
    _queueService = QueueService();
    _queueList = <Antrean>[];
    var antrean = await _queueService.readQueue();
    antrean.forEach((antrean) {
      setState(() {
        var model = Antrean();
        model.id = antrean['id'];
        model.name = antrean['name'];
        model.nik = antrean['nik'];
        model.noHp = antrean['noHp'];
        model.tanggal = antrean['tanggal'];
        model.alamat = antrean['alamat'];
        model.category = antrean['category'];
        _queueList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Colors.deepPurple,
                  Colors.purple,
                  Colors.purpleAccent,
                ])),
          ),
          title: const Text('Queue App')),
      drawer: const DrawerNavigation(),
      //HomeBanner(),
      body: RefreshIndicator(
        onRefresh: () => getAllQueue(),
        child: ListView.builder(
          itemCount: _queueList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DetailQueuePage(),
                  settings: RouteSettings(arguments: _queueList[index]),
                ));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  child: ListTile(
                    leading: Image.network(
                        'https://static.vecteezy.com/system/resources/previews/001/190/573/non_2x/flower-icon-png.png'),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_queueList[index].name ?? 'No Name')
                      ],
                    ),
                    subtitle: Text(_queueList[index].category ?? 'No Category'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const QueuePage())),
        child: const Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
