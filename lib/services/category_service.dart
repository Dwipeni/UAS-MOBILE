import 'dart:ui';

import 'package:uas_mobile/models/queue_category.dart';
import 'package:uas_mobile/sqlite/repository.dart';

class CategorySevice{
  Repository _repository;

  CategorySevice() {
    _repository = Repository();
  }

  //membuat data
  saveCategory(Category category) async {
    return await _repository.insertData('category', category.categoryMap());
  }

  //menampilkan data
  readCategory() async {
    return await _repository.readData('category');
  }

  //menampilkan data dari tabel dengan Id
  readCategoryById(categoryId) async {
    return await _repository.readDataById('category', categoryId);
  }

  //update data
  updateCategory(Category category) async {
    return await _repository.updateData('category', category.categoryMap());
  }

  //hapus data
  deleteCategory(categoryId) async {
    return await _repository.deleteData('category', categoryId);
  }
}