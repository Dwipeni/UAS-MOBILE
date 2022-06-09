import 'package:uas_mobile/pages/queue_by_category.dart';
import 'package:uas_mobile/pages/home_page.dart';
import 'package:uas_mobile/pages/category_page.dart';
import 'package:uas_mobile/services/category_service.dart';
import 'package:flutter/material.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _categoryList = List<Widget>();

  CategorySevice _categorySevice = CategorySevice();

  @override
  initState() {
    super.initState();
    getAllCategory();
  }

  getAllCategory() async {
    var category = await _categorySevice.readCategory();

    category.forEach((category) {
      setState(() {
        _categoryList.add(InkWell(
          onTap: () => Navigator.push(
            context, 
            new MaterialPageRoute(
              builder: (context) => new QueueByCategory(category: category['name']))),
          child: ListTile(
            title: Text(category['name']),
          ),
        ));
      });
    });
  }

  @override
  Widget build (BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/pin.jpg'),
              ),
              accountName: Text('Admin'),
              accountEmail: Text('admin@gmail.com'),
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
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage())),
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Queue Categories'),
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoryPage())),
            ),
            Divider(),
            Column(
              children: _categoryList
            ),
          ],
        ),
      ),
    );
  }
}