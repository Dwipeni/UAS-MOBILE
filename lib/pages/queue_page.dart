// ignore_for_file: deprecated_member_use, unnecessary_string_escapes

import 'package:flutter/services.dart';
import 'package:uas_mobile/models/queue.dart';
import 'package:uas_mobile/services/category_service.dart';
import 'package:uas_mobile/services/queue_service.dart';
import 'package:flutter/material.dart';

class QueuePage extends StatefulWidget {
  const QueuePage({Key key}) : super(key: key);

  @override
  _QueuePageState createState() => _QueuePageState();
}

class _QueuePageState extends State<QueuePage> {
  final TextEditingController _queueNameController = TextEditingController();
  // final TextEditingController _queueDescriptionController = TextEditingController();
  final TextEditingController _queueNikController = TextEditingController();
  final TextEditingController _queueNoHpController = TextEditingController();
  final TextEditingController _queueTanggalController = TextEditingController();
  final TextEditingController _queueAlamatController = TextEditingController();
  final List<DropdownMenuItem> _category = <DropdownMenuItem>[];
  final FocusNode _focusName = FocusNode();
  final FocusNode _focusNik = FocusNode();
  final FocusNode _focusNoHp = FocusNode();
  final FocusNode _focusTanggal = FocusNode();
  final FocusNode _focusAlamat = FocusNode();
  final FocusNode _focusCategory = FocusNode();
  String _selectedValue = '';
  DateTime tanggal = DateTime(2019);

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _queueTanggalController.text =
        '${tanggal.day}-${tanggal.month}-${tanggal.year}';
    _loadCategory();
  }

  _loadCategory() async {
    var _categoryService = CategorySevice();
    var category = await _categoryService.readCategory();
    setState(() {
      category.forEach((category) {
        _category.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
      if (_category.isNotEmpty) {
        _selectedValue = _category.elementAt(0).value;
      }
    });
  }

  _showSuccessSnackBar(message) {
    SnackBar _snackBar = SnackBar(content: message);
    ScaffoldMessenger.of(_globalKey.currentContext).showSnackBar(_snackBar);
  }

  _addQueue() async {
    if (_validation()) {
      var queueObject = Antrean();
      queueObject.name = _queueNameController.text;
      queueObject.nik = _queueNikController.text;
      queueObject.noHp = _queueNoHpController.text;
      queueObject.tanggal = _queueTanggalController.text;
      queueObject.alamat = _queueAlamatController.text;
      queueObject.category = _selectedValue;
      queueObject.konfirmasi = 0;
      var _flowerService = QueueService();
      var result = await _flowerService.saveQueue(queueObject);
      if (result > 0) {
        _showSuccessSnackBar(const Text('Created'));
      }
    }
  }

  _validation() {
    if (_queueNameController.text.isEmpty) {
      ScaffoldMessenger.of(_globalKey.currentContext).showSnackBar(SnackBar(
        content: const Text('Nama Harus Diisi!'),
        backgroundColor: Colors.red[600],
      ));
      _focusName.requestFocus();
      return false;
    } else if (_queueNikController.text.isEmpty) {
      ScaffoldMessenger.of(_globalKey.currentContext).showSnackBar(SnackBar(
        content: const Text('NIK Harus Diisi!'),
        backgroundColor: Colors.red[600],
      ));
      _focusNik.requestFocus();
      return false;
    } else if (_queueNoHpController.text.isEmpty) {
      ScaffoldMessenger.of(_globalKey.currentContext).showSnackBar(SnackBar(
        content: const Text('Nomor Handphone Harus Diisi!'),
        backgroundColor: Colors.red[600],
      ));
      _focusNoHp.requestFocus();
      return false;
    } else if (_queueTanggalController.text.isEmpty) {
      ScaffoldMessenger.of(_globalKey.currentContext).showSnackBar(SnackBar(
        content: const Text('Tanggal Vaksin Harus Diisi!'),
        backgroundColor: Colors.red[600],
      ));
      _focusTanggal.requestFocus();
      return false;
    } else if (_queueAlamatController.text.isEmpty) {
      ScaffoldMessenger.of(_globalKey.currentContext).showSnackBar(SnackBar(
        content: const Text('Alamat Harus Diisi!'),
        backgroundColor: Colors.red[600],
      ));
      _focusAlamat.requestFocus();
      return false;
    } else if (_selectedValue.isEmpty) {
      ScaffoldMessenger.of(_globalKey.currentContext).showSnackBar(SnackBar(
        content: const Text('Kategori is required!'),
        backgroundColor: Colors.red[600],
      ));
      _focusCategory.requestFocus();
      return false;
    } else if (_queueNikController.text.length < 16) {
      ScaffoldMessenger.of(_globalKey.currentContext).showSnackBar(SnackBar(
        content: const Text('NIK Minimal Terdiri Dari 16 Karakter!'),
        backgroundColor: Colors.red[600],
      ));
      _focusNik.requestFocus();
      return false;
    }
    return true;
  }

  _selectDate() async {
    DateTime selectedDate = await showDatePicker(
      context: _globalKey.currentContext,
      initialDate: tanggal,
      firstDate: DateTime(2019),
      lastDate: DateTime(2023),
      helpText: "PILIH TANGGAL",
      cancelText: "BATAL",
      confirmText: "PILIH",
      fieldLabelText: "MASUKKAN TANGGAL",
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: const ColorScheme.light(primary: Colors.deepPurple),
        ),
        child: child,
      ),
    );
    if (selectedDate != tanggal && selectedDate != null) {
      tanggal = selectedDate;
      _queueTanggalController.text =
          '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Insert Queue Data'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _queueNameController,
              focusNode: _focusName,
              decoration: const InputDecoration(
                  labelText: 'Nama', hintText: 'Masukkan nama Anda'),
            ),
            TextField(
              controller: _queueNikController,
              focusNode: _focusNik,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(
                    '[a-z A-Z \\- \\, \\. \\* \\# \\( \\) \\/ \s]')),
                LengthLimitingTextInputFormatter(16),
              ],
              decoration: const InputDecoration(
                  labelText: 'NIK', hintText: 'Masukkan NIK Anda '),
            ),
            TextField(
              controller: _queueNoHpController,
              focusNode: _focusNoHp,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(
                    '[a-z A-Z \\- \\, \\. \\* \\# \\( \\) \\/ \s]')),
                LengthLimitingTextInputFormatter(16),
              ],
              decoration: const InputDecoration(
                  labelText: 'Nomor Handphone',
                  hintText: 'Masukkan nomor handphone Anda '),
            ),
            TextField(
              controller: _queueTanggalController,
              focusNode: _focusTanggal,
              readOnly: true,
              decoration: const InputDecoration(
                  labelText: 'Tanggal Vaksin',
                  hintText: 'Masukkan tanggal vaksin Anda'),
              onTap: () => _selectDate(),
            ),
            TextField(
              controller: _queueAlamatController,
              focusNode: _focusAlamat,
              decoration: const InputDecoration(
                  labelText: 'Alamat', hintText: 'Masukkan Alamat Anda '),
            ),
            DropdownButtonFormField(
                value: _selectedValue,
                focusNode: _focusCategory,
                items: _category,
                hint: const Text('Kategori'),
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                }),
            const SizedBox(height: 20),
            RaisedButton(
              onPressed: () => _addQueue(),
              color: Colors.purple,
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
