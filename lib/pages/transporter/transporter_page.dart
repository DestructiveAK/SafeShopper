import 'package:SafeShopper/pages/settings_screen.dart';
import 'package:SafeShopper/pages/transporter/order_page.dart';
import 'package:SafeShopper/utils/animate_child.dart';
import 'package:flutter/material.dart';

class TransporterPage extends StatefulWidget {
  @override
  _TransporterPageState createState() => _TransporterPageState();
}

class _TransporterPageState extends State<TransporterPage> {
  int _currentIndex = 0;
  List<String> _title = [
    "Orders",
    "Settings",
  ];
  List<Widget> _page = [
    TransporterOrderPage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title[_currentIndex]),
        centerTitle: true,
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
            icon: Icon(Icons.settings),
            label: "Setting",
          ),
        ],
      ),
    );
  }
}
