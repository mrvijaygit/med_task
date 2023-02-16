import 'package:flutter/material.dart';

import '../utils/globals.dart';
import '../utils/styles.dart';

class CustomButton extends StatefulWidget {
  final void Function()? onTap;
  final String text;
  final double? padding;
  bool? isDisabled = false;

  CustomButton(
      {required this.text, required this.onTap, this.padding, this.isDisabled
      });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  double _scale = 0.0;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTap: widget.onTap,
      onTapUp: _tapUp,
      onTapDown: _tapDown,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: 50,
          margin: EdgeInsets.symmetric(
              horizontal: widget.padding == null || widget.padding == 0
                  ? 0.0
                  : widget.padding!,
              vertical: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                if (widget.isDisabled == true)
                  const Color.fromARGB(255, 202, 197, 197)
                else
                  Globals.primary,
                if (widget.isDisabled == true)
                  const Color.fromARGB(255, 202, 197, 197)
                else
                  Globals.primary,
              ])),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.text.toUpperCase(),
                style: Styles.buttonStyle(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}