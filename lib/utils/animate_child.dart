import 'package:flutter/material.dart';

class AnimateChild extends StatefulWidget {
  final Widget child;

  AnimateChild({@required this.child});

  @override
  _AnimateChildState createState() => _AnimateChildState();
}

class _AnimateChildState extends State<AnimateChild>
    with SingleTickerProviderStateMixin {
      
  AnimationController _animationController;

  Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      curve: Curves.easeIn,
      parent: _animationController,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.reset();
    _animationController.forward();
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
