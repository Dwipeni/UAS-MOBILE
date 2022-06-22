class Antrean {
  int id;
  String name;
  String nik;
  String noHp;
  String tanggal;
  String alamat;
  String category;

  // Konstruktor versi 2: konversi dari Map ke Item
  queueMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['nik'] = nik;
    mapping['noHp'] = noHp;
    mapping['tanggal'] = tanggal;
    mapping['alamat'] = alamat;
    mapping['category'] = category;

    return mapping;
  }
}