import 'package:SafeShopper/pages/home_screen.dart';
import 'package:SafeShopper/pages/login_screen.dart';
import 'package:SafeShopper/pages/settings_screen.dart';
import 'package:SafeShopper/pages/signup_screen.dart';
import 'package:SafeShopper/providers/theme_provider.dart';
import 'package:SafeShopper/utils/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ThemeModeNotifier())],
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeShopper',
      theme: ThemeData.from(colorScheme: ColorScheme.light()).copyWith(
        primaryColor: Colors.cyan,
      ),
      darkTheme: ThemeData.from(colorScheme: ColorScheme.dark()),
      themeMode: Provider.of<ThemeModeNotifier>(context).mapThemeMode(),
      debugShowCheckedModeBanner: false,
      home: AuthService.handleAuth(),
      routes: {
        '/home': (BuildContext context) => HomePage(),
        '/signup': (BuildContext context) => SignUpPage(),
        '/login': (BuildContext context) => LoginPage(),
        '/settings': (BuildContext context) => SettingsPage(),
      },
    );
  }
}
