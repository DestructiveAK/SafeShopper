// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final String orderId;
  OrderDetailsPage({@required this.orderId //Making constructor for the class
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Order Details"),
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("/orders")
                .doc(orderId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView(
                children: [
                  Card(
                    margin: EdgeInsets.all(10),
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text("Order Id"),
                      subtitle: Text(orderId),
                    ),
                  ),
                  Card(
                    elevation: 15,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: FutureBuilder<DocumentSnapshot>(
                        future: snapshot.data.data()["customerId"].get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          }
                          return Column(
                            children: [
                              ListTile(
                                title: Text("Customer Name"),
                                subtitle: Text(
                                  snapshot.data.data()["name"],
                                ),
                              ),
                              ListTile(
                                title: Text("Phone No"),
                                subtitle: Text(
                                  snapshot.data.data()["phone"],
                                ),
                              ),
                              ListTile(
                                title: Text("Address"),
                                subtitle: Text(
                                  snapshot.data.data()["address"],
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  Card(
                      elevation: 15,
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: DataTable(
                        columns: [
                          DataColumn(
                            label: Text(
                              "Product Name",
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "Qty",
                            ),
                          ),
                        ],
                        rows: snapshot.data
                            .data()["products"]
                            .map<DataRow>(
                              (product) => DataRow(
                                cells: [
                                  DataCell(
                                    FutureBuilder<DocumentSnapshot>(
                                      future: product["productId"].get(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container();
                                        }
                                        return Text(
                                            snapshot.data.data()["name"]);
                                      },
                                    ),
                                  ),
                                  DataCell(
                                    Text("${product["qty"]}"),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      )),
                ],
              );
            }));
  }
}
