// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:uas_mobile/models/queue.dart';
import 'package:uas_mobile/services/queue_service.dart';

class DetailQueuePage extends StatefulWidget {
  const DetailQueuePage({Key key}) : super(key: key);

  @override
  State<DetailQueuePage> createState() => _DetailQueuePageState();
}

class _DetailQueuePageState extends State<DetailQueuePage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  QueueService _queueService;
  Antrean queue = Antrean();

  @override
  void initState() {
    super.initState();
    _queueService = QueueService();
  }

  _confirmQueue() async {
    queue.konfirmasi = 1;
    var result = await _queueService.updateConfirmationQueue(queue);
    if (result > 0) {
      Navigator.of(context).pop();
      _showSuccessSnackBar(const Text('Konfirmasi Berhasil!'));
    } else {
      _showSuccessSnackBar(const Text('Konfirmasi Gagal!'));
    }
  }

  _showSuccessSnackBar(message) {
    SnackBar _snackBar = SnackBar(content: message);
    ScaffoldMessenger.of(_globalKey.currentContext).showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    queue = ModalRoute.of(context).settings.arguments as Antrean;
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Colors.deepPurple,
                Colors.purple,
                Colors.purpleAccent
              ])),
        ),
        title: const Text('Detail Queue'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue:
                  queue.name.isNotEmpty ? queue.name : '(Tidak Ada NIK)',
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Nama',
                hintText: 'Nama',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
            TextFormField(
              initialValue:
                  queue.nik.isNotEmpty ? queue.nik : '(Tidak Ada NIK)',
              readOnly: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'NIK',
                hintText: 'NIK',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
            TextFormField(
              initialValue: queue.noHp.isNotEmpty
                  ? queue.noHp
                  : '(Tidak Ada Nomor Handphone)',
              readOnly: true,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Nomor Handphone',
                hintText: 'Nomor Handphone',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
            TextFormField(
              initialValue: queue.tanggal.isNotEmpty
                  ? queue.tanggal
                  : '(Tidak Ada Tanggal Vaksin)',
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Tanggal Vaksin',
                hintText: 'Tanggal Vaksin',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
            TextFormField(
              initialValue:
                  queue.alamat.isNotEmpty ? queue.alamat : '(Tidak Ada Alamat)',
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                hintText: 'Alamat',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
            TextFormField(
              initialValue: queue.category.isNotEmpty
                  ? queue.category
                  : '(Tidak Ada Kategori)',
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                hintText: 'Kategori',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            RaisedButton(
              onPressed: () => _confirmQueue(),
              color: Colors.purple,
              child: const Text('Konfirmasi',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
