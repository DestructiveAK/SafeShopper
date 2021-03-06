import 'package:SafeShopper/pages/order_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransporterOrderDetails extends StatelessWidget {
  final String orderId;
  TransporterOrderDetails({this.orderId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          OrderDetails(orderId: orderId),
          Material(
              elevation: 15,
              child: Container(
              padding: EdgeInsets.all(12),
              child: RaisedButton(onPressed: (){
                FirebaseFirestore.instance.collection("/orders").doc(orderId).update({
                  "status" : "delivered"
                });
                Navigator.of(context).pop();
              },
              padding: EdgeInsets.all(15),
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), 
              color: Colors.blue,
              child: Text("Mark as Delivered"),
              ),
              width: double.infinity,
            ),
          )
        ],
      ),
    );
  }
}