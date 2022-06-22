import 'package:flutter/material.dart';
import 'package:uas_mobile/models/queue.dart';

class DetailQueuePage extends StatelessWidget {
  const DetailQueuePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Antrean queue = ModalRoute.of(context).settings.arguments as Antrean;
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
              initialValue: queue.name.isNotEmpty ? queue.name : '(Tidak Ada NIK)',
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
              initialValue: queue.nik.isNotEmpty ? queue.nik : '(Tidak Ada NIK)',
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
              initialValue: queue.noHp.isNotEmpty ? queue.noHp : '(Tidak Ada Nomor Handphone)',
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
              initialValue: queue.tanggal.isNotEmpty ? queue.tanggal : '(Tidak Ada Tanggal Vaksin)',
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
              initialValue: queue.alamat.isNotEmpty ? queue.alamat : '(Tidak Ada Alamat)',
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
              initialValue: queue.category.isNotEmpty ? queue.category : '(Tidak Ada Kategori)',
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
          ],
        ),
      ),
    );
  }
}
