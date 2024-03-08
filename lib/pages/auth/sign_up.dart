import 'dart:typed_data';

import 'package:auth_tutorial/data/providers/user_provider.dart';
import 'package:auth_tutorial/utils/constants.dart';
import 'package:auth_tutorial/utils/validators.dart';
import 'package:auth_tutorial/widgets/primary_btn.dart';
import 'package:auth_tutorial/widgets/text_field.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _errorMessage;

  // ignore: unused_field
  Uint8List? _image;

  final _signUpKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _signUpKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Create an Account"),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _emailController,
                  leadingIcon: Constants.emailIcon,
                  autoCorrect: false,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => Validators.validateEmail(value),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _passwordController,
                  leadingIcon: Constants.passwordIcon,
                  autoCorrect: false,
                  hintText: "Password",
                  validator: (value) => Validators.validatePassword(value),
                  obscureText: true,
                  isPassword: true,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _confirmPasswordController,
                  leadingIcon: Constants.passwordIcon,
                  autoCorrect: false,
                  hintText: "Confirm Password",
                  validator: (value) => Validators.validatePassword(value),
                  obscureText: true,
                  isPassword: true,
                ),
                const SizedBox(height: 10),
                Text(_errorMessage ?? ""),
                PrimaryBtn(
                    buttonText: "Sign up",
                    onPressed: () async {
                      if (_signUpKey.currentState!.validate()) {
                        try {
                          await UserProvider().signUpWithEmailAndPassword(
                              _emailController.text, _passwordController.text);
                        } catch (e) {
                          setState(() {
                            _errorMessage = 'Failed to Create Profile';
                          });
                        }
                      }
                    }),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Already have an account? "),
                  TextButton(
                    onPressed: () {
                      _emailController.clear();
                      _passwordController.clear();
                      _confirmPasswordController.clear();
                      setState(() {
                        Navigator.pushReplacementNamed(context, '/log_in');
                      });
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
