import 'package:SafeShopper/providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  final String productId;

  ProductDetails({@required this.productId});
  @override
  Widget build(BuildContext context) {
    bool isButtonDisabled = Provider.of<CartProvider>(context).checkInCart(
        FirebaseFirestore.instance.collection('/products').doc(productId));
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('/products')
            .doc(productId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          Size size = MediaQuery.of(context).size;
          return ListView(children: [
            Hero(
              tag: snapshot.data.data()["image"],
              child: Image.network(
                snapshot.data.data()["image"],
                height: size.width,
                width: size.width,
              ),
            ),
            Divider(
              thickness: 5,
            ),
            Column(
              children: [
                Text(
                  snapshot.data.data()["name"],
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Text(
                  snapshot.data.data()["description"],
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Price: " + snapshot.data.data()["price"].toString(),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  thickness: 5,
                ),
                RaisedButton(
                  color: Colors.cyan,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  onPressed: isButtonDisabled
                      ? null
                      : () {
                          Provider.of<CartProvider>(context, listen: false)
                              .addItem({
                            'productId': FirebaseFirestore.instance
                                .collection('/products')
                                .doc(productId),
                            'qty': 1
                          });
                        },
                  child: Text(
                    isButtonDisabled ? 'Go to cart' : 'Add to cart',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ]);
        },
      ),
    );
  }
}
