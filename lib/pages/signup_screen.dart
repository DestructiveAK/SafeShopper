import 'package:SafeShopper/utils/auth_service.dart';
import 'package:SafeShopper/utils/input_field.dart';
import 'package:SafeShopper/utils/login_signup_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _name;

  String _address;

  String _phone;

  String _email;

  String _password;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                image: AssetImage('assets/images/abstract3.png'),
              ),
              bottom: 0,
              right: 0,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SIGN UP',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    'assets/images/abstract2.svg',
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.03),
                  InputField(
                    hintText: 'Name',
                    icon: Icons.person,
                    keyboardType: TextInputType.name,
                    onChange: (value) {
                      _name = value;
                    },
                  ),
                  InputField(
                    hintText: 'Address',
                    icon: Icons.landscape,
                    keyboardType: TextInputType.streetAddress,
                    onChange: (value) {
                      _address = value;
                    },
                  ),
                  InputField(
                    hintText: 'Phone Number',
                    icon: Icons.phone_android,
                    keyboardType: TextInputType.phone,
                    onChange: (value) {
                      _phone = value;
                    },
                  ),
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
                    text: 'Sign Up',
                    onPressed: () {
                      AuthService.signUp(context, _name, _phone, _address, _email, _password);
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  GestureDetector(
                    child: Text(
                      'Already have an account? Login',
                      style: TextStyle(
                        color: Color(0xFF6F35A5),
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/login');
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
