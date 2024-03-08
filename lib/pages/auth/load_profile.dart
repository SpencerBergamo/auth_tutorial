import 'package:auth_tutorial/data/providers/user_provider.dart';
import 'package:auth_tutorial/pages/auth/complete_profile.dart';
import 'package:auth_tutorial/pages/auth/log_in.dart';
import 'package:auth_tutorial/pages/user_screens/user_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadProfile extends StatefulWidget {
  const LoadProfile({super.key});

  @override
  State<LoadProfile> createState() => _LoadProfileState();
}

class _LoadProfileState extends State<LoadProfile> {
  Widget widgetToPush = const Center(child: CircularProgressIndicator());

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final userProv = Provider.of<UserProvider>(context, listen: false);
    String res = await userProv.loadProfile();

    switch (res) {
      case 'success':
        setState(() {
          widgetToPush = const UserHome();
        });
        break;
      case 'no_user':
        setState(() {
          widgetToPush = const CompleteProfile();
        });
        break;
      case 'error':
        setState(() {
          widgetToPush = const LogIn();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widgetToPush;
  }
}
