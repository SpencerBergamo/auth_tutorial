import 'package:auth_tutorial/pages/log_in.dart';
import 'package:auth_tutorial/pages/sign_up.dart';
import 'package:auth_tutorial/pages/user_home.dart';
import 'package:auth_tutorial/utils/user_provider.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Authentication Tutorial',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const UserHome();
              } else if (snapshot.hasError) {
                return const Scaffold(
                  body: Center(
                    child: Text("Something went wrong"),
                  ),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return const SignUp();
          },
        ),
        routes: {
          '/user_home': (context) => const UserHome(),
          '/sign_up': (context) => const SignUp(),
          '/log_in': (context) => const LogIn(),
        });
  }
}
