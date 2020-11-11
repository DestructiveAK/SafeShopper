import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuyerOrderDetails extends StatelessWidget {
  final String orderId;
  BuyerOrderDetails({this.orderId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("/orders")
                    .doc(orderId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<dynamic> productList = snapshot.data.data()["products"];
                  Future<double> totalPrice = calcPrice(productList);
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
                      Card(
                        elevation: 15,
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Price:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                FutureBuilder(
                                  future: totalPrice,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Text("");
                                    }
                                    return Text("${snapshot.data}",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ));
                                  },
                                ),
                              ]),
                        ),
                      )
                    ],
                  );
                }),
          ),
          Material(
            elevation: 15,
            child: Container(
              padding: EdgeInsets.all(12),
              child: RaisedButton(
                onPressed: () {
                  showAlertDialog(context, orderId);
                },
                padding: EdgeInsets.all(15),
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.blue,
                child: Text("Cancel"),
              ),
              width: double.infinity,
            ),
          )
        ],
      ),
    );
  }
}

Future<double> calcPrice(List<dynamic> productList) async {
  double totalPrice = 0;
  for (int i = 0; i < productList.length; i++) {
    dynamic product = await productList[i]["productId"].get();
    totalPrice += product.data()["price"] * productList[i]["qty"];
  }
  return totalPrice;
}
Future<void> showAlertDialog(BuildContext context, String orderId) async {
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text("Warning"),
      content: Text("Do you want to cancel your order ?"),
      actions: [
        FlatButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection("/orders")
                  .doc(orderId)
                  .delete();
              Navigator.of(context).pop();
            },
            child: Text("Yes")),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("No"))
      ],
    ),
  );
}
