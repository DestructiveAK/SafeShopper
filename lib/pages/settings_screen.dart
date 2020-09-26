import 'dart:ui';
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

    return Container(
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
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('/users')
                    .doc(AuthService.userId())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final userDetails = snapshot.data.data();
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
                          onTap: () {
                            showBottomSheet<void>(
                              context: context,
                              builder: (context) => ChangeDetailsAndPassword(
                                child: ChangeUserDetails(),
                                height: 450,
                              ),
                            );
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Change Password'),
                          leading: Icon(Icons.lock),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            showBottomSheet<void>(
                              context: context,
                              builder: (context) => ChangeDetailsAndPassword(
                                child: ChangePassword(),
                                height: 300,
                              ),
                            );
                          },
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Logout'),
                          leading: Icon(Icons.logout),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: AuthService.signOut,
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
    );
  }
}

class UserDetailsTile extends StatelessWidget {
  const UserDetailsTile(
      {Key key,
      @required this.field,
      @required this.value,
      @required this.icon})
      : super(key: key);

  final String field;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(field),
      subtitle: Text(value),
      leading: Icon(
        icon,
        size: 30,
      ),
    );
  }
}

class ChangeDetailsAndPassword extends StatelessWidget {
  @override
  ChangeDetailsAndPassword(
      {Key key, @required this.child, @required this.height});

  final double height;
  final Widget child;

  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        height: height,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: child,
          ),
          elevation: 10,
          margin: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

class ChangeUserDetails extends StatefulWidget {
  @override
  _ChangeUserDetailsState createState() => _ChangeUserDetailsState();
}

class _ChangeUserDetailsState extends State<ChangeUserDetails> {
  String _name;
  String _phone;
  String _address;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Change Details',
          style: TextStyle(
            fontSize: 35,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        TextInputField(
          hintText: 'Name',
          icon: Icons.person,
          keyboardType: TextInputType.name,
          onChanged: (value) {
            _name = value;
          },
        ),
        TextInputField(
          hintText: 'Phone',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            _phone = value;
          },
        ),
        TextInputField(
          hintText: 'Address',
          icon: Icons.landscape,
          keyboardType: TextInputType.streetAddress,
          onChanged: (value) {
            _address = value;
          },
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
              onPressed: () {
                AuthService.changeUserDetails(_name, _address, _phone);
                Navigator.of(context).pop();
              },
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Update',
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Cancel',
              ),
            ),
          ],
        )
      ],
    );
  }
}

class TextInputField extends StatelessWidget {
  const TextInputField(
      {Key key,
      @required this.hintText,
      @required this.icon,
      @required this.onChanged,
      this.obscureText = false,
      this.keyboardType = TextInputType.name})
      : super(key: key);

  final IconData icon;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(icon),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.black,
            )),
        onChanged: onChanged,
      ),
    );
  }
}

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String _password;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Change Password',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        TextInputField(
          hintText: 'New Password',
          icon: Icons.lock,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          onChanged: (value) {
            _password = value;
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
              onPressed: () {},
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Update',
              ),
            ),
            FlatButton(
              onPressed: () {},
              color: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Cancel',
              ),
            ),
          ],
        )
      ],
    );
  }
}
