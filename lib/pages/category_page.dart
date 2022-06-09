import 'package:uas_mobile/core/color.dart';
import 'package:uas_mobile/models/queue_category.dart';
import 'package:uas_mobile/pages/home_page.dart';
import 'package:uas_mobile/services/category_service.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();

  var _category = Category();
  var _categoryService = CategorySevice();

  List<Category> _categoryList = List<Category>();

  var category;

  var _editCategoryNameController = TextEditingController();
  var _editCategoryDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllCategory();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllCategory() async {
    _categoryList = List<Category>();
    var category = await _categoryService.readCategory();
    category.forEach((category) {
      setState(() {
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
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: <Widget>[
          FlatButton(
            color: Colors.red,
            onPressed: ()=>Navigator.pop(context),
            child: Text('Cancel'), 
            textColor: white
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () async {
              _category.name = _categoryNameController.text;
              _category.description = _categoryDescriptionController.text;

              var result = await _categoryService.saveCategory(_category);
              if (result > 0) {
                print(result);
                Navigator.pop(context);
                getAllCategory();
              }
            },
            child: Text('Save'),
            textColor: white
          )
        ],
        title: Text('Categories Form'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _categoryNameController,
                decoration: InputDecoration(
                  hintText: 'Write a category',
                  labelText: 'Category'
                ),
              ),
              TextField(
                controller: _categoryDescriptionController,
                decoration: InputDecoration(
                  hintText: 'Write a description',
                  labelText: 'Description'
                ),
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
              child: Text('Cancel'), textColor: Colors.white
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () async {
                _category.id = category[0]['id'];
                _category.name = _editCategoryNameController.text;
                _category.description = _editCategoryDescriptionController.text;

                var result = await _categoryService.updateCategory(_category);
                if (result > 0) {
                  print(result);
                  Navigator.pop(context);
                  getAllCategory();
                  _showSuccessSnackBar(Text('Updated!'));
                }
              },
              child: Text('Update'), textColor: Colors.white
            ),
          ],
          title: Text('Edit Queue Category'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _editCategoryNameController,
                  decoration: InputDecoration(
                    hintText: 'Write a category', labelText: 'Category'
                  ),
                ),
                TextField(
                  controller: _editCategoryDescriptionController,
                  decoration: InputDecoration(
                    hintText: 'Write a description', labelText: 'Description'
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
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
              child: Text('Cancel'), textColor: Colors.white
            ),
            FlatButton(
              color: Colors.red,
              onPressed: () async {
                var result = await _categoryService.deleteCategory(categoryId);
                if (result > 0) {
                  print(result);
                  Navigator.pop(context);
                  getAllCategory();
                  _showSuccessSnackBar(Text('Deleted!'));
                }
              },
              child: Text('Delete'), textColor: Colors.white
            ),
          ],
          title: Text('Are you sure want to delete this?'),
        );
      }
    );
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
        leading: RaisedButton(
          onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage())),
          elevation: 0.0,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          color: Colors.deepPurple
        ),
        title: Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: _categoryList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
            child: Card(
              elevation: 8.0,
              child: ListTile(
                leading: IconButton(icon: Icon(Icons.edit), onPressed: () {
                  _editCategory(context, _categoryList[index].id);
                }),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_categoryList[index].name),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: (){
                        _deleteFormDialog(context, _categoryList[index].id);
                      })
                  ]
                ),
              ),
            ),
          );
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add), backgroundColor: Colors.purple,
      ),
    );
  }
}