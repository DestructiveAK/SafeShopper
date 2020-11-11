import 'package:SafeShopper/utils/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  List<Map<String, dynamic>> checkedItemList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("/products").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            List<QueryDocumentSnapshot> documents = snapshot.data.docs;
            
            for (int i = 0; i < documents.length; i++) {
              checkedItemList.add({
                "productId": documents[i].id,
                "checked": false,
              });
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(documents[index].data()["name"]),
                  subtitle: Text(documents[index].data()["description"]),
                  controlAffinity: ListTileControlAffinity.trailing,
                  value: checkedItemList[index]["checked"],
                  onChanged: (value) {
                    checkedItemList[index]["checked"] = value;
                    setState(() {});
                  },
                );
              },
              itemCount: documents.length,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<DocumentReference> items = [];
          for (int i = 0; i < checkedItemList.length; i++) {
            if (checkedItemList[i]["checked"]) {
              items.add(FirebaseFirestore.instance
                  .collection("/products")
                  .doc(checkedItemList[i]["productId"]));
            }
          }
          if(items.length>0)
          {
          FirebaseFirestore.instance
              .collection("/users")
              .doc(AuthService.userId())
              .get()
              .then((user) {
            FirebaseFirestore.instance
                .collection("/shops")
                .doc(user.data()["shopId"])
                .update({"products": FieldValue.arrayUnion(items)});
          }).whenComplete(() {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop();
            });
          });
        }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}

