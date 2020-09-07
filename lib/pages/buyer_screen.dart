import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuyerPage extends StatefulWidget {
  @override
  _BuyerPageState createState() => _BuyerPageState();
}

class _BuyerPageState extends State<BuyerPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('/shops').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Some error has occured. Please try again later.'),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapshot.data.docs;
          return ListView.builder(
            physics: ClampingScrollPhysics(),
            padding: EdgeInsets.all(8.0),
            itemCount: documents.length,
            itemBuilder: (context, index) => Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                leading: getIcon(documents[index].data()['category']),
                title: Text(documents[index].data()['name']),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                          'Owner: ${documents[index].data()['ownerName']}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                          'Category: ${documents[index].data()['category']}'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Icon getIcon(String data) {
    IconData icon;
    switch (data) {
      case 'Electronics':
        icon = Icons.electrical_services;
        break;
      case 'Food':
        icon = Icons.fastfood;
        break;
      case 'Grocery':
        icon = Icons.local_grocery_store;
        break;
      case 'Furniture':
        icon = Icons.single_bed;
        break;
      case 'Medicine':
        icon = Icons.medical_services;
        break;
      case 'Bakery':
        icon = Icons.cake;
        break;
      default:
        icon = Icons.shopping_basket;
    }
    return Icon(
      icon,
      size: 35.0,
    );
  }
}
