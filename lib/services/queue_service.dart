import 'package:uas_mobile/models/queue.dart';
import 'package:uas_mobile/sqlite/repository.dart';

class QueueService {
  Repository _repository;

  QueueService() {
    _repository = Repository();
  }

  //buat tabel flower
  saveQueue(Antrean antrean) async {
    return await _repository.insertData('antrean', antrean.queueMap());
  }

  //tampilkan tabel flower
  readQueue() async {
    return await _repository.readData('antrean');
  }

  //tampilkan tabel flower dengan category
  readQueueByCategory(category) async {
    return await _repository.readDataByColumn('antrean', 'category', category);
  }
}