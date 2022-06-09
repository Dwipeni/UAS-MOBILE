import 'package:uas_mobile/models/queue.dart';
import 'package:uas_mobile/services/category_service.dart';
import 'package:uas_mobile/services/queue_service.dart';
import 'package:flutter/material.dart';

class QueuePage extends StatefulWidget {
  @override
  _QueuePageState createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  var _queueNameController = TextEditingController();
  var _queueDescriptionController = TextEditingController();
  var _queueNikController = TextEditingController();
  var _queueNoHpController = TextEditingController();
  var _queueTanggalController = TextEditingController();
  var _queueAlamatController = TextEditingController();

  var _selectedValue;
  var _category = List<DropdownMenuItem>();
  
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadCategory();
  }

  _loadCategory() async {
    var _categoryService = CategorySevice();
    var category = await _categoryService.readCategory();
    category.forEach((category) {
      setState(() {
        _category.add(DropdownMenuItem(child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
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
        title: Text('Insert Queue Data'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _queueNameController,
              decoration: InputDecoration(
                labelText: 'Nama',
                hintText: 'Masukkan nama Anda'
              ),
            ),
            TextField(
              controller: _queueNikController,
              decoration: InputDecoration(
                labelText: 'NIK',
                hintText: 'Masukkan NIK Anda '
              ),
            ),
            TextField(
              controller: _queueNoHpController,
              decoration: InputDecoration(
                labelText: 'Nomor Handphone',
                hintText: 'Masukkan nomor handphone Anda '
              ),
            ),
            TextField(
              controller: _queueTanggalController,
              decoration: InputDecoration(
                labelText: 'Tanggal Vaksin',
                hintText: 'Masukkan tanggal vaksin Anda'
              ),
            ),
            TextField(
              controller: _queueAlamatController,
              decoration: InputDecoration(
                labelText: 'Alamat',
                hintText: 'Masukkan Alamat Anda '
              ),
            ),
            DropdownButtonFormField(
              value: _selectedValue,
              items: _category, 
              hint: Text('Category'),
              onChanged: (value) {
                setState(() {
                  _selectedValue = value;
                });
              }
            ),
            SizedBox(
              height: 20
            ),
            RaisedButton(
              onPressed: () async {
                var queueObject = Antrean();

                queueObject.name = _queueNameController.text;
                queueObject.nik = _queueNikController.text;
                queueObject.noHp = _queueNoHpController.text;
                queueObject.tanggal = _queueTanggalController.text;
                queueObject.alamat = _queueAlamatController.text;
                queueObject.category = _selectedValue;

                var _flowerService = QueueService();
                var result = await _flowerService.saveQueue(queueObject);

                if(result > 0) {
                  _showSuccessSnackBar(Text('Created'));
                }

                print(result);
              }, 
              color: Colors.purple, 
              child: Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}