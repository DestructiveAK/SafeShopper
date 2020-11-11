import 'package:SafeShopper/pages/buyer_order_details.dart';
import 'package:SafeShopper/utils/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuyerOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection("/users")
                .doc(AuthService.userId())
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("/orders")
                      .where("customerId",isEqualTo: FirebaseFirestore.instance.collection("/users").doc(AuthService.userId()))
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data.docs.length == 0) {
                      return Center(
                        child: Text("No Orders"),
                      );
                    }
                    List<QueryDocumentSnapshot> documents = snapshot.data.docs;
                    return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) => Card(
                              elevation: 8,
                              margin: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: ListTile(
                                onTap: () {

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BuyerOrderDetails(
                                          orderId: documents[index].id),
                                    ),
                                  );
                                },
                                title: Text("Order id: ${documents[index].id}"),

                              ),
                            ));
                  });
            }));
  }
}
