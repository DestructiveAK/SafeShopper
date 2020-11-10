import 'package:SafeShopper/utils/auth_service.dart';

class Cart {
  String userId;
  String shopId;
  List<Map<String, dynamic>> productList;

  Cart(String shopId) {
    this.userId = AuthService.userId();
    this.shopId = shopId;
    this.productList = [];
  }

  void addItemToCart(Map<String, dynamic> item) {
    productList.add(item);
  }

  void removeItemFromCart(Map<String, dynamic> item) {
    productList.remove(item);
  }

  void changeQuantity(String productId, int qty) {
    int index =
        productList.indexWhere((element) => element['productId'] == productId);
    productList[index]['qty'] = qty;
  }
}
