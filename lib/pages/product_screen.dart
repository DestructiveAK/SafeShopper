import 'package:SafeShopper/pages/product_list.dart';
import 'package:SafeShopper/utils/animate_child.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String shopId;

  ProductPage({
    @required this.shopId,
  });

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _currentIndex = 0;

  List<Widget> _page;

  List<String> _title = [
    'Products',
    'Cart',
  ];

  @override
  void initState() {
    _page = [
      ProductList(
        shopId: widget.shopId,
      ),
      Container(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title[_currentIndex]),
        centerTitle: true,
      ),
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
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          )
        ],
      ),
      body: AnimateChild(child: _page[_currentIndex]),
    );
  }
}
