import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBottomSheet extends StatelessWidget {
  @override
  BlurBottomSheet({Key key, @required this.child, @required this.height});

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
