import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final String buttonText;
  // add an optional controller
  final AnimationController? controller;
  final Function()? onPressed;

  const AnimatedButton({
    super.key,
    required this.buttonText,
    this.controller,
    this.onPressed,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
