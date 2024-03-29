import 'package:auth_tutorial/data/providers/user_provider.dart';
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log In"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _loginKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Log Into Your Account"),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _emailController,
                  leadingIcon: Constants.emailIcon,
                  autoCorrect: false,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
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
                      if (_loginKey.currentState!.validate()) {
                        try {
                          await UserProvider().signInWithEmailAndPassword(
                              _emailController.text, _passwordController.text);
                        } catch (e) {
                          setState(() {
                            _errorMessage = 'Invalid email or password';
                          });
                        }
                      }
                    }),
                const SizedBox(height: 10),
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
    );
  }
}
