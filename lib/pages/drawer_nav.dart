import 'package:uas_mobile/pages/queue_by_category.dart';
import 'package:uas_mobile/pages/home_page.dart';
import 'package:uas_mobile/pages/category_page.dart';
import 'package:uas_mobile/services/category_service.dart';
import 'package:flutter/material.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key key}) : super(key: key);

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  final List<Widget> _categoryList = <Widget>[];
  final CategorySevice _categorySevice = CategorySevice();

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
            MaterialPageRoute(
              builder: (context) => QueueByCategory(category: category['name']))),
          child: ListTile(
            title: Text(category['name']),
          ),
        ));
      });
    });
  }

  @override
  Widget build (BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
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
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage())),
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text('Queue Categories'),
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CategoryPage())),
          ),
          const Divider(),
          Column(
            children: _categoryList
          ),
        ],
      ),
    );
  }
}