import 'package:auth_tutorial/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final dynamic controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool autoCorrect;
  final bool isPassword; // password identifiers
  final FaIcon? leadingIcon;
  final IconData? trailingIcon;
  bool obscureText;

  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.autoCorrect = false,
    this.isPassword = false,
    this.leadingIcon,
    this.trailingIcon,
    this.obscureText = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // bool _obscureText = isPassword;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Padding(
              padding: const EdgeInsets.all(20), child: widget.leadingIcon),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(5),
            child: widget.isPassword == true
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.obscureText = !widget.obscureText;
                      });
                    },
                    icon: widget.obscureText
                        ? Constants.eyeHide
                        : Constants.eyeShow,
                  )
                : null,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 88, 88, 88),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 88, 88, 88),
            ),
          ),
        ),
        validator: widget.validator,
      ),
    );
  }
}
