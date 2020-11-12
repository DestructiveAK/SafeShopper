import 'package:SafeShopper/pages/cart_page.dart';
import 'package:SafeShopper/pages/product_list.dart';
import 'package:SafeShopper/providers/cart_provider.dart';
import 'package:SafeShopper/utils/animate_child.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  CartProvider _cartProvider;

  @override
  void initState() {
    _cartProvider = CartProvider(widget.shopId);
    _page = [
      ProductList(
        shopId: widget.shopId,
        cartProvider: _cartProvider,
      ),
      CartPage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _cartProvider,
      lazy: false,
      child: WillPopScope(
        onWillPop: () async {
          if (_currentIndex == 0) {
            return true;
          } else {
            _currentIndex = 0;
            setState(() {});
            return false;
          }
        },
        child: Scaffold(
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
        ),
      ),
    );
  }
}
