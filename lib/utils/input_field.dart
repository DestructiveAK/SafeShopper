import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key key,
      @required this.hintText,
      @required this.icon,
      this.isObscureText = false,
      this.keyboardType = TextInputType.visiblePassword,
      @required this.onChange})
      : super(key: key);

  final String hintText;
  final IconData icon;
  final bool isObscureText;
  final TextInputType keyboardType;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Color(0xFFF1E6FF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        obscureText: isObscureText,
        keyboardType: keyboardType,
        cursorColor: Color(0xFF6F35A5),
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Color(0xFF6F35A5),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
        ),
        onChanged: onChange,
      ),
    );
  }
}
