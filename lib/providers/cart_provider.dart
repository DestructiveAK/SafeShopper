import 'package:SafeShopper/providers/cart_model.dart';
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

  void removeItem(Map<String, dynamic> item) {
    _cart.removeItemFromCart(item);
    notifyListeners();
  }

  void changeQty(String productId, int qty) {
    _cart.changeQuantity(productId, qty);
    notifyListeners();
  }
}
