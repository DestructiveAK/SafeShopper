import 'package:SafeShopper/utils/auth_service.dart';
import 'package:SafeShopper/utils/input_field.dart';
import 'package:SafeShopper/utils/login_signup_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;

  String _password;

  String _error = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Image(
                image: AssetImage('assets/images/abstract5.png'),
                height: size.height * 0.25,
              ),
              top: 0,
              left: 0,
            ),
            Positioned(
              child: Image(
                image: AssetImage('assets/images/abstract4.png'),
              ),
              bottom: 0,
              left: 0,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   'LOGIN',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  SizedBox(height: size.height * 0.03),
                  // SvgPicture.asset(
                  //   'assets/images/abstract6.svg',
                  //   height: size.height * 0.35,
                  // ),
                  Image.asset(
                    'assets/images/abstract6.png',
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.03),
                  (_error.isNotEmpty)
                      ? Container(
                          height: size.height * 0.03,
                          width: size.width * 0.8,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.red),
                          ),
                          child: Align(
                            child: Text(_error),
                            alignment: Alignment.centerLeft,
                          ),
                        )
                      : Container(),
                  SizedBox(height: size.height * 0.005),
                  InputField(
                    hintText: 'Email',
                    icon: Icons.mail,
                    keyboardType: TextInputType.emailAddress,
                    onChange: (value) {
                      _email = value;
                    },
                  ),
                  InputField(
                    hintText: 'Password',
                    icon: Icons.lock,
                    isObscureText: true,
                    onChange: (value) {
                      _password = value;
                    },
                  ),
                  LoginSignUpButton(
                    text: 'Login',
                    onPressed: () {
                      AuthService.signIn(_email, _password, context, (value) {
                        _error = value;
                      });
                      if (_error.isNotEmpty) {
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  GestureDetector(
                    child: Text(
                      'Don\'t have an account? Sign Up',
                      style: TextStyle(
                        color: Color(0xFF6F35A5),
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
