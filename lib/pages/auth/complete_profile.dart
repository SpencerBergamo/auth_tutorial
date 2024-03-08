import 'dart:typed_data';

import 'package:auth_tutorial/data/providers/user_provider.dart';
import 'package:auth_tutorial/utils/constants.dart';
import 'package:auth_tutorial/utils/utils.dart';
import 'package:auth_tutorial/utils/validators.dart';
import 'package:auth_tutorial/widgets/primary_btn.dart';
import 'package:auth_tutorial/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final _auth = FirebaseAuth.instance;
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phonenumberController = TextEditingController();
  String? _errorMessage;

  Uint8List? _image;

  final _completeProfileKey = GlobalKey<FormState>();

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _phonenumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _completeProfileKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => selectImage(),
                  child: _image != null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.camera, size: 40),
                        ),
                ),
                CustomTextField(
                  controller: _nameController,
                  hintText: "Name",
                  leadingIcon: Constants.nameIcon,
                  autoCorrect: false,
                  validator: (value) => Validators.validateName(value),
                ),
                CustomTextField(
                    controller: _usernameController,
                    hintText: "Username",
                    leadingIcon: Constants.usernameIcon,
                    autoCorrect: false,
                    validator: (value) => Validators.validateUsername(value)),
                CustomTextField(
                    controller: _phonenumberController,
                    hintText: "Phone Number",
                    leadingIcon: Constants.phoneIcon,
                    autoCorrect: false,
                    validator: (value) =>
                        Validators.validatePhoneNumber(value)),
                Text(_errorMessage ?? ""),
                PrimaryBtn(
                    buttonText: "Complete Profile",
                    onPressed: () async {
                      if (_completeProfileKey.currentState!.validate()) {
                        try {
                          final res = await UserProvider().completeProfile(
                              uid: _auth.currentUser!.uid,
                              email: _auth.currentUser!.email.toString(),
                              name: _nameController.text,
                              username: _usernameController.text,
                              file: _image!,
                              phoneNumber: _phonenumberController.text);

                          switch (res) {
                            case ('error'):
                              setState(() {
                                _errorMessage = 'Failed to Create Profile';
                              });
                              break;
                            case ('success'):
                              setState(() {
                                Navigator.pushReplacementNamed(
                                    context, '/load_profile');
                              });
                              break;
                          }
                        } catch (e) {
                          setState(() {
                            _errorMessage = 'Failed to Create Profile';
                          });
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
