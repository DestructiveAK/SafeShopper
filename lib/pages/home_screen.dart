import 'package:SafeShopper/pages/buyer_screen.dart';
import 'package:SafeShopper/pages/settings_screen.dart';
import 'package:SafeShopper/utils/animate_child.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  List<Widget> _page = [
    BuyerPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'Home' : 'Settings'),
        centerTitle: true,
        actions: [
          if (_currentIndex == 0)
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {},
            )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        currentIndex: _currentIndex,
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          )
        ],
      ),
      // body: AnimatedCrossFade(
      //   duration: Duration(milliseconds: 500),
      //   firstChild: _page[0],
      //   secondChild: _page[1],
      //   crossFadeState: _currentIndex == 0
      //       ? CrossFadeState.showFirst
      //       : CrossFadeState.showSecond,
      // ),
      body: AnimateChild(child: _page[_currentIndex]),
    );
  }
}
