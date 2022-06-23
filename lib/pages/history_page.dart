import 'package:flutter/material.dart';
import 'package:uas_mobile/models/queue.dart';
import 'package:uas_mobile/services/queue_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  QueueService _queueService;
  final List<Antrean> _queueList = [];

  @override
  void initState() {
    super.initState();
    getConfirmationQueue();
  }

  getConfirmationQueue() async {
    _queueService = QueueService();
    var antrean = await _queueService.readQueueConfirmation();
    setState(() {
      _queueList.clear();
      antrean.forEach((element) {
        var model = Antrean();
        model.id = element['id'];
        model.name = element['name'];
        model.nik = element['nik'];
        model.noHp = element['noHp'];
        model.tanggal = element['tanggal'];
        model.alamat = element['alamat'];
        model.category = element['category'];
        model.konfirmasi = element['konfirmasi'];
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
        title: const Text('Queue History'),
      ),
      //HomeBanner(),
      body: RefreshIndicator(
        onRefresh: () => getConfirmationQueue(),
        child: ListView.builder(
          itemCount: _queueList.length,
          itemBuilder: (context, index) {
            return Padding(
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
            );
          },
        ),
      ),
    );
  }
}
