import 'package:uas_mobile/models/queue.dart';
import 'package:uas_mobile/services/queue_service.dart';
import 'package:flutter/material.dart';

class QueueByCategory extends StatefulWidget {
  final String category;
  QueueByCategory({this.category});

  @override
  _QueueByCategoryState createState() => _QueueByCategoryState();
}

class _QueueByCategoryState extends State<QueueByCategory> {
  List<Antrean> _queueList = List<Antrean>();
  QueueService _queueService = QueueService();

  @override
  void initState() {
    super.initState();
    getQueueByCategory();
  }

  getQueueByCategory() async {
    var antrean = await _queueService.readQueueByCategory(this.widget.category);
    antrean.forEach((antrean) {
      setState(() {
        var model = Antrean();
        model.name = antrean['name'];
        model.nik = antrean['nik'];
        
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
                Colors.purpleAccent
                ]
            )          
          ),
        ),
        title: Text('Queue by Category'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: ListView.builder(
            itemCount: _queueList.length, 
            itemBuilder: (context, index){
              return Padding(
                padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)
                  ),
                  elevation: 8,
                  child: ListTile(
                    //leading: Image.network('https://static.vecteezy.com/system/resources/previews/001/190/573/non_2x/flower-icon-png.png'),
                    title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_queueList[index].name)
                    ],
                  ),
                  subtitle: Text(_queueList[index].nik, textAlign: TextAlign.justify)
                  ),
                ),
              );
            }))
        ],
      ),
    );
  }
}