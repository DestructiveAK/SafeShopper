import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final String productId;

  ProductDetails({@required this.productId});

  @override
  Widget build(BuildContext context) {
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                  onPressed: (){
                      print("Button Pressed !!");
                  }, 
                  child: Text("Add to cart",style: TextStyle(fontSize: 20),),
                )
              ],
            ),
          ]);
        },
      ),
    );
  }
}
