import 'package:flutter/material.dart';
import 'package:SafeShopper/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppThemeMode _themeMode;

  @override
  Widget build(BuildContext context) {
    _themeMode = Provider.of<ThemeModeNotifier>(context).getThemeMode();

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(left: 10, right: 10, top: 15),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Theme",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
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
    );
  }
}
