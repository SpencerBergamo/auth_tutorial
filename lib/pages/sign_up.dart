import 'dart:typed_data';

import 'package:auth_tutorial/repositories/auth_repo.dart';
import 'package:auth_tutorial/utils/constants.dart';
import 'package:auth_tutorial/utils/utils.dart';
import 'package:auth_tutorial/utils/validators.dart';
import 'package:auth_tutorial/widgets/primary_btn.dart';
import 'package:auth_tutorial/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

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

  Uint8List? _image;

  final _signUpKey = GlobalKey<FormState>();

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _signUpKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Create an Account"),
                  const SizedBox(height: 20),
                  _image != null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey,
                          child: FaIcon(Constants.profileIcon.icon),
                        ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: selectImage, child: const Text("Edit Photo")),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _emailController,
                    leadingIcon: Constants.emailIcon,
                    hintText: "Email",
                    validator: (value) => Validators.validateEmail(value),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _passwordController,
                    leadingIcon: Constants.passwordIcon,
                    hintText: "Password",
                    validator: (value) => Validators.validatePassword(value),
                    isPassword: true,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: _confirmPasswordController,
                    leadingIcon: Constants.passwordIcon,
                    hintText: "Confirm Password",
                    validator: (value) => Validators.validatePassword(value),
                    isPassword: true,
                  ),
                  const SizedBox(height: 10),
                  Text(_errorMessage ?? ""),
                  PrimaryBtn(
                      buttonText: "Sign up",
                      onPressed: () async {
                        try {
                          await AuthRepository().signUpWithEmailAndPassword(
                              _emailController.text, _passwordController.text);
                          setState(() {
                            Navigator.pushReplacementNamed(
                                context, '/user_home');
                          });
                        } catch (e) {
                          setState(() {
                            _errorMessage = 'Failed to Create Profile';
                          });
                        }
                      }),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () async {
                      try {
                        await AuthRepository().signInWithGoogle();
                        setState(() {
                          Navigator.pushReplacementNamed(context, '/user_home');
                        });
                      } catch (e) {
                        setState(() {
                          _errorMessage = 'An error occurred';
                        });
                      }
                    },
                    child: const Text("Continue with Google"),
                  ),
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
      ),
    );
  }
}
