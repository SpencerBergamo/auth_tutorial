import 'package:auth_tutorial/pages/auth/load_profile.dart';
import 'package:auth_tutorial/pages/auth/log_in.dart';
import 'package:auth_tutorial/pages/auth/sign_up.dart';
import 'package:auth_tutorial/pages/user_screens/user_home.dart';
import 'package:auth_tutorial/data/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Authentication Tutorial',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case (ConnectionState.active):
                if (snapshot.hasData) {
                  return const LoadProfile();
                } else {
                  return const LogIn();
                }
              case (ConnectionState.waiting):
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              default:
                return const Scaffold(
                  body: Center(
                    child: Icon(Icons.camera, size: 100),
                  ),
                );
            }
          },
        ),
        routes: {
          '/user_home': (context) => const UserHome(),
          '/sign_up': (context) => const SignUp(),
          '/log_in': (context) => const LogIn(),
        });
  }
}
