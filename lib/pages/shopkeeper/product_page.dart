import 'package:SafeShopper/utils/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("/users")
            .doc(AuthService.userId())
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("/shops")
                .doc(snapshot.data.data()["shopId"])
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              DocumentSnapshot shop = snapshot.data;
              return ListView.builder(
                itemCount: shop.data()["products"].length,
                itemBuilder: (context, index) => Card(
                  child: FutureBuilder<DocumentSnapshot>(
                    future: shop.data()["products"][index].get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return ListTile(
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: FutureBuilder(
                            future: FirebaseStorage.instance
                                .ref()
                                .child(snapshot.data.data()["name"] + ".jpg")
                                .getDownloadURL(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Container();
                              }
                              return Image.network(snapshot.data,
                                  fit: BoxFit.cover);
                            },
                          ),
                        ),
                        title: Text(snapshot.data.data()["name"]),
                        subtitle: Text(snapshot.data.data()["description"]),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("/shops")
                                .doc(shop.id)
                                .update({
                              "products": FieldValue.arrayRemove(
                                  [shop.data()["products"][index]])
                            });
                          },
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.all(10),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
