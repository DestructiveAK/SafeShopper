import 'package:flutter/material.dart';

class LoginSignUpButton extends StatelessWidget {
  const LoginSignUpButton({
    Key key,
    @required this.text,
    @required this.onPressed
  }) : super(key: key);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: FlatButton(
        child: Text(text),
        onPressed: onPressed,
        color: Color(0xFF6F35A5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        height: size.height * 0.05,
      ),
    );
  }
}
