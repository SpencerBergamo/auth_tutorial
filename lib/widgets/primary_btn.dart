import 'package:auth_tutorial/utils/constants.dart';
import 'package:flutter/material.dart';

class PrimaryBtn extends StatelessWidget {
  final String buttonText;
  final Function()? onPressed;

  const PrimaryBtn({super.key, this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.boundryEdges,
      child: TextButton(
        onPressed: onPressed,
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
