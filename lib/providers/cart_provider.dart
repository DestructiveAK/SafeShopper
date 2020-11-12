import 'package:SafeShopper/providers/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class CartProvider with ChangeNotifier {
  Cart _cart;

  CartProvider(String shopId) {
    _cart = Cart(shopId);
    notifyListeners();
  }

  Cart get getCart => _cart;

  void addItem(Map<String, dynamic> item) {
    _cart.addItemToCart(item);
    notifyListeners();
  }

  void removeItem(DocumentReference productId) {
    _cart.removeItemFromCart(productId);
    notifyListeners();
  }

  void changeQty(DocumentReference productId, int qty) {
    _cart.changeQuantity(productId, qty);
    notifyListeners();
  }

  void placeOrder() {
    FirebaseFirestore.instance.collection('/orders').doc().set({
      'customerId': _cart.userId,
      'shopId': _cart.shopId,
      'status': 'ordered',
      'products': _cart.productList,
    });
    _cart.productList = [];
    notifyListeners();
  }

  bool checkInCart(DocumentReference productId) {
    return _cart.checkInCart(productId);
  }
}
