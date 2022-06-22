// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables

import 'package:uas_mobile/core/color.dart';
import 'package:uas_mobile/models/queue_category.dart';
import 'package:uas_mobile/services/category_service.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryDescriptionController =
      TextEditingController();
  final TextEditingController _editCategoryNameController =
      TextEditingController();
  final TextEditingController _editCategoryDescriptionController =
      TextEditingController();
  final Category _category = Category();
  final CategorySevice _categoryService = CategorySevice();
  final List<Category> _categoryList = <Category>[];
  var category;

  @override
  void initState() {
    super.initState();
    getAllCategory();
  }

  getAllCategory() async {
    var category = await _categoryService.readCategory();
    setState(() {
      _categoryList.clear();
      category.forEach((category) {
        var categoryModel = Category();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      _editCategoryNameController.text = category[0]['name'];
      _editCategoryDescriptionController.text = category[0]['description'];
    });
    _editFormDialog(context);
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  color: Colors.red,
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                  textColor: white),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () async {
                    if (_categoryNameController.text.isNotEmpty) {
                      _category.name = _categoryNameController.text;
                      _category.description =
                          _categoryDescriptionController.text;
                      var result =
                          await _categoryService.saveCategory(_category);
                      if (result > 0) {
                        Navigator.pop(context);
                        _categoryNameController.text = '';
                        _categoryDescriptionController.text = '';
                        await getAllCategory();
                      }
                    } else {
                      _showSuccessSnackBar(const Text('Form is Required!'));
                    }
                  },
                  child: const Text('Save'),
                  textColor: white)
            ],
            title: const Text('Categories Form'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _categoryNameController,
                    decoration: const InputDecoration(
                        hintText: 'Write a category', labelText: 'Category'),
                  ),
                  TextField(
                    controller: _categoryDescriptionController,
                    decoration: const InputDecoration(
                        hintText: 'Write a description',
                        labelText: 'Description'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  color: Colors.red,
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                  textColor: Colors.white),
              FlatButton(
                  color: Colors.blue,
                  onPressed: () async {
                    if (_editCategoryNameController.text.isNotEmpty) {
                      _category.id = category[0]['id'];
                      _category.name = _editCategoryNameController.text;
                      _category.description =
                          _editCategoryDescriptionController.text;
                      var result =
                          await _categoryService.updateCategory(_category);
                      if (result > 0) {
                        Navigator.pop(context);
                        getAllCategory();
                        _showSuccessSnackBar(const Text('Updated!'));
                      }
                    } else {
                      _showSuccessSnackBar(const Text('Form is Required!'));
                    }
                  },
                  child: const Text('Update'),
                  textColor: Colors.white),
            ],
            title: const Text('Edit Queue Category'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _editCategoryNameController,
                    decoration: const InputDecoration(
                        hintText: 'Write a category', labelText: 'Category'),
                  ),
                  TextField(
                    controller: _editCategoryDescriptionController,
                    decoration: const InputDecoration(
                        hintText: 'Write a description',
                        labelText: 'Description'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  color: Colors.green,
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                  textColor: Colors.white),
              FlatButton(
                  color: Colors.red,
                  onPressed: () async {
                    var result =
                        await _categoryService.deleteCategory(categoryId);
                    if (result > 0) {
                      Navigator.pop(context);
                      _showSuccessSnackBar(const Text('Deleted!'));
                      await getAllCategory();
                    }
                  },
                  child: const Text('Delete'),
                  textColor: Colors.white),
            ],
            title: const Text('Are you sure want to delete this?'),
          );
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
        leading: RaisedButton(
            onPressed: () => Navigator.of(context).pop(),
            elevation: 0.0,
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            color: Colors.deepPurple),
        title: const Text('Categories'),
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _editCategory(context, _categoryList[index].id);
                      }),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_categoryList[index].name),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => _deleteFormDialog(
                              context, _categoryList[index].id),
                        )
                      ]),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
