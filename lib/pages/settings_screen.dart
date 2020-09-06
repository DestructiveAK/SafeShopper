import 'package:SafeShopper/utils/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:SafeShopper/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppThemeMode _themeMode =
        Provider.of<ThemeModeNotifier>(context).getThemeMode();

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(left: 5, right: 5, top: 15),
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Theme",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        color: Theme.of(context).accentColor.withOpacity(0.1),
                      ),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: RadioListTile(
                        value: AppThemeMode.SYSTEM,
                        groupValue: _themeMode,
                        onChanged: (value) {
                          Provider.of<ThemeModeNotifier>(context, listen: false)
                              .setThemeMode(value);
                        },
                        title: Text('System'),
                        controlAffinity: ListTileControlAffinity.trailing,
                        activeColor: Theme.of(context).accentColor,
                      ),
                    ),
                    Divider(
                      height: 1.5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor.withOpacity(0.1),
                      ),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: RadioListTile(
                        value: AppThemeMode.LIGHT,
                        groupValue: _themeMode,
                        onChanged: (value) {
                          Provider.of<ThemeModeNotifier>(context, listen: false)
                              .setThemeMode(value);
                        },
                        title: Text('Light'),
                        controlAffinity: ListTileControlAffinity.trailing,
                        activeColor: Theme.of(context).accentColor,
                      ),
                    ),
                    Divider(
                      height: 1.5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                        color: Theme.of(context).accentColor.withOpacity(0.1),
                      ),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: RadioListTile(
                        value: AppThemeMode.DARK,
                        groupValue: _themeMode,
                        onChanged: (value) {
                          Provider.of<ThemeModeNotifier>(context, listen: false)
                              .setThemeMode(value);
                        },
                        title: Text('Dark'),
                        controlAffinity: ListTileControlAffinity.trailing,
                        activeColor: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 10,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('/users')
                      .where('userId', isEqualTo: AuthService.userId())
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final userDetails = snapshot.data.docs[0].data();
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          UserDetailsTile(
                            field: 'Name',
                            value: userDetails['name'],
                            icon: Icons.person,
                          ),
                          UserDetailsTile(
                            field: 'Email',
                            value: userDetails['email'],
                            icon: Icons.email,
                          ),
                          UserDetailsTile(
                            field: 'Phone',
                            value: userDetails['phone'],
                            icon: Icons.phone,
                          ),
                          UserDetailsTile(
                            field: 'Address',
                            value: userDetails['address'],
                            icon: Icons.landscape,
                          ),
                          Divider(),
                          ListTile(
                            title: Text('Change Details'),
                            leading: Icon(Icons.update),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          Divider(),
                          ListTile(
                            title: Text('Change Password'),
                            leading: Icon(Icons.lock),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          Divider(),
                          ListTile(
                            title: Text('Logout'),
                            leading: Icon(Icons.logout),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: (){
                              Navigator.of(context).pop();
                              AuthService.signOut();
                            },
                          ),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      );
                    } else {
                      return SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
