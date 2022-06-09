import 'package:uas_mobile/core/color.dart';
import 'package:uas_mobile/models/queue.dart';
import 'package:uas_mobile/pages/drawer_nav.dart';
import 'package:uas_mobile/pages/queue_page.dart';
import 'package:uas_mobile/services/queue_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QueueService _queueService;

  List<Antrean> _queueList = List<Antrean>();

  @override
  initState() {
    super.initState();
    getAllQueue();
  }

  getAllQueue() async {
    _queueService = QueueService();
    _queueList = List<Antrean>();
  
    var antrean = await _queueService.readQueue();

    antrean.forEach((antrean) {
      setState(() {
        var model = Antrean();
        model.id = antrean['id'];
        model.name = antrean['name'];
        model.nik = antrean['nik'];
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                Colors.deepPurple,
                Colors.purple,
                Colors.purpleAccent,
                ]
            )          
          ),
        ),
        title: Text('Queue App')
      ),
      drawer: DrawerNavigation(),
      //HomeBanner(),
      body: ListView.builder(
        itemCount: _queueList.length, itemBuilder: (context, index){
          return Padding(
            padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0)
              ),
              child: ListTile (
                leading: Image.network('https://static.vecteezy.com/system/resources/previews/001/190/573/non_2x/flower-icon-png.png'),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_queueList[index].name ?? 'No Name')
                  ],
                ),
                subtitle: Text(_queueList[index].category??'No Category'),
              ),
            ),
          );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => QueuePage())), 
        child: Icon(Icons.add), backgroundColor: Colors.purple)
    );
  }
}