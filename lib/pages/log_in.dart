import 'dart:ffi';

import 'package:auth_tutorial/repositories/auth_repo.dart';
import 'package:auth_tutorial/utils/constants.dart';
import 'package:auth_tutorial/utils/validators.dart';
import 'package:auth_tutorial/widgets/primary_btn.dart';
import 'package:auth_tutorial/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  final _loginKey = GlobalKey<FormState>();

  void login() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _loginKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Log Into Your Account"),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _emailController,
                    leadingIcon: Constants.emailIcon,
                    autoCorrect: false,
                    hintText: "Email",
                    validator: (value) => Validators.validateEmail(
                      value,
                    ),
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
                  // Working on this one
                  const Padding(
                    padding: Constants.boundryEdges,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Forgot Password?"),
                      ],
                    ),
                  ),
                  Text(
                    _errorMessage ?? '',
                    style: TextStyle(
                      color: Constants.errorStyle.color,
                    ),
                  ),
                  const SizedBox(height: 10),
                  PrimaryBtn(
                      buttonText: 'Log In',
                      onPressed: () async {
                        if (!_loginKey.currentState!.validate()) {
                          const Center(child: CircularProgressIndicator());
                          try {
                            await AuthRepository().signInWithEmailAndPassword(
                                _emailController.text,
                                _passwordController.text);
                            // login;
                          } catch (e) {
                            setState(() {
                              _errorMessage = 'Invalid email or password';
                            });
                          }
                        }
                      }),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () async {
                      try {
                        await AuthRepository().signInWithGoogle();
                        // setState(() {
                        //   Navigator.pushReplacementNamed(context, '/user_home');
                        // });
                      } catch (e) {
                        setState(() {
                          _errorMessage = 'An error occurred';
                        });
                      }
                    },
                    child: const Text("Continue with Google"),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        _emailController.clear();
                        _passwordController.clear();
                        Navigator.pushReplacementNamed(context, '/sign_up');
                      },
                      child: const Text("Sign Up",
                          style: TextStyle(color: Colors.blue)),
                    ),
                  ]),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
