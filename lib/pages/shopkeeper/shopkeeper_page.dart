import 'package:SafeShopper/pages/settings_screen.dart';
import 'package:SafeShopper/pages/shopkeeper/order_page.dart';
import 'package:SafeShopper/pages/shopkeeper/product_page.dart';
import 'package:SafeShopper/pages/shopkeeper/shopkeeper_add_item.dart';

import 'package:SafeShopper/utils/animate_child.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopkeeperPage extends StatefulWidget {
  @override
  _ShopkeeperPageState createState() => _ShopkeeperPageState();
}

class _ShopkeeperPageState extends State<ShopkeeperPage> {
  int _currentIndex = 0;
  List<String> _title = [
    "Orders",
    "Products",
    "Settings",
  ];
  List<Widget> _page = [
    OrderPage(),
    AddItemPage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title[_currentIndex]),
        centerTitle: true,
        actions: [
          if (_currentIndex == 1)
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddItem()));
                }),
        ],
      ),
      body: AnimateChild(child: _page[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (_currentIndex != index) {
            _currentIndex = index;
            setState(() {});
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag,
            ),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add Item",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
          ),
        ],
      ),
    );
  }
}
