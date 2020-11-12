import 'package:SafeShopper/utils/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  DocumentReference userId;
  String shopId;
  List<Map<String, dynamic>> productList;

  Cart(String shopId) {
    this.userId = FirebaseFirestore.instance
        .collection('/users')
        .doc(AuthService.userId());
    this.shopId = shopId;
    this.productList = [];
  }

  void addItemToCart(Map<String, dynamic> item) {
    productList.add(item);
  }

  void removeItemFromCart(DocumentReference productId) {
    productList.removeWhere((element) => element['productId'] == productId);
  }

  void changeQuantity(DocumentReference productId, int qty) {
    int index =
        productList.indexWhere((element) => element['productId'] == productId);
    productList[index]['qty'] = qty;
  }

  bool checkInCart(DocumentReference productId) {
    int index =
        productList.indexWhere((element) => element['productId'] == productId);
    return index != -1;
  }
}
