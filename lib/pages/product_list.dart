import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final String shopId;
  ProductList({@required this.shopId});
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
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
                      return GridTile(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FutureBuilder(
                              future: FirebaseStorage.instance
                                  .ref()
                                  .child(
                                      snapshot.data.data()['name'] + '.jpg')
                                  .getDownloadURL(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Container();
                                }
                                return Image.network(snapshot.data,
                                    height: 120, width: 120);
                              },
                            ),
                            Text(snapshot.data.data()['name'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Text('Rs  ${snapshot.data.data()['price']}'),
                          ],
                        ),
                      );
                    },
                  )));
        },
      ),
    );
  }
}
