import 'package:SafeShopper/providers/cart_model.dart';
import 'package:SafeShopper/providers/cart_provider.dart';
import 'package:SafeShopper/utils/price_calculator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<CartProvider>(context).getCart;
    return Container(
      padding: EdgeInsets.all(10),
      child: (cart.productList.length > 0)
          ? ListView(
              children: [
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
                      DataColumn(
                        label: Text('Price'),
                      ),
                      DataColumn(
                        label: Text(''),
                      ),
                    ],
                    rows: cart.productList
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
                                    return Text(snapshot.data.data()["name"]);
                                  },
                                ),
                              ),
                              DataCell(
                                DropdownButton<int>(
                                  value: product['qty'],
                                  items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                                      .map(
                                        (int value) => DropdownMenuItem(
                                          value: value,
                                          child: Text(value.toString()),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (int value) {
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .changeQty(product['productId'], value);
                                  },
                                ),
                              ),
                              DataCell(
                                FutureBuilder<DocumentSnapshot>(
                                  future: product['productId'].get(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Container();
                                    }
                                    return Text(
                                      '${snapshot.data.data()['price'] * product['qty']}',
                                    );
                                  },
                                ),
                              ),
                              DataCell(
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    Provider.of<CartProvider>(
                                      context,
                                      listen: false,
                                    ).removeItem(product['productId']);
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          FutureBuilder(
                            future: calcPrice(cart.productList),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("");
                              }
                              return Text(
                                "${snapshot.data}",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              );
                            },
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    elevation: 8,
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Text('Place Order'),
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .placeOrder();
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          title: Text('Order Placed'),
                          content: Text(
                            'Your order has been successfully placeed. ' +
                                'Please go to orders to see details.',
                          ),
                          actions: [
                            FlatButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            )
          : Center(
              child: Text('Your cart is empty'),
            ),
    );
  }
}
