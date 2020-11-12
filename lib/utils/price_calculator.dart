Future<double> calcPrice(List<dynamic> productList) async {
  double totalPrice = 0;
  for (int i = 0; i < productList.length; i++) {
    dynamic product = await productList[i]["productId"].get();
    totalPrice += product.data()["price"] * productList[i]["qty"];
  }
  return totalPrice;
}
