import 'package:SafeShopper/pages/product_details.dart';
import 'package:SafeShopper/providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  final String shopId;
  final CartProvider cartProvider;
  ProductList({
    @required this.shopId,
    @required this.cartProvider,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('/shops')
            .doc(shopId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return GridView.builder(
            itemCount: snapshot.data.data()['products'].length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) => Card(
              elevation: 15,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.all(8),
              child: FutureBuilder<DocumentSnapshot>(
                future: snapshot.data.data()['products'][index].get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return InkResponse(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                            value: cartProvider,
                            child: ProductDetails(productId: snapshot.data.id),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Hero(
                          tag: snapshot.data.data()['image'],
                          child: Image.network(
                            snapshot.data.data()['image'],
                            height: 120,
                            width: 120,
                          ),
                        ),
                        Text(
                          snapshot.data.data()['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text('Rs  ${snapshot.data.data()['price']}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
